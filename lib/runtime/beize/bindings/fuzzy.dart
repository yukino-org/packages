import 'dart:math';
import 'package:beize_vm/beize_vm.dart';
import '../converter/exports.dart';

abstract class FuzzySearchBindings {
  static void bind(final BeizeNamespace namespace) {
    final BeizeObjectValue value = BeizeObjectValue();
    value.setNamedProperty(
      'new',
      BeizeNativeFunctionValue.sync(
        (final BeizeNativeFunctionCall call) {
          final BeizeObjectValue options = call.argumentAt(0);
          final BeizeListValue items = options.getNamedProperty('items');
          final BeizeListValue keys = options.getNamedProperty('keys');
          return newClient(
            items: items.elements,
            keys: keys.elements.map(
              (final BeizeValue x) {
                final BeizeObjectValue casted = x.cast();
                return _FuzzySearchKey(
                  getter: casted.getNamedProperty('getter'),
                  weight: casted
                      .getNamedProperty('weight')
                      .cast<BeizeNumberValue>()
                      .value,
                );
              },
            ).toList(),
          );
        },
      ),
    );
    namespace.declare('FuzzySearch', value);
  }

  static BeizeValue newClient({
    required final List<BeizeValue> items,
    required final List<_FuzzySearchKey> keys,
  }) {
    final BeizeObjectValue value = BeizeObjectValue();
    value.setNamedProperty(
      'search',
      BeizeNativeFunctionValue.async(
        (final BeizeNativeFunctionCall call) async {
          final BeizeStringValue terms = call.argumentAt(0);
          final List<BeizeObjectValue> results = <BeizeObjectValue>[];
          final BeizeStringValue matchKey = BeizeStringValue('match');
          for (final BeizeValue item in items) {
            double match = 0;
            for (final _FuzzySearchKey key in keys) {
              final BeizeValue againstValue = call.frame.callValue(
                key.getter,
                <BeizeValue>[item],
              ).unwrapUnsafe();
              final String against = againstValue.kToString();
              final int distance = calculateLevenshteinDistance(
                terms.value,
                against,
              );
              match += distance * key.weight;
            }
            final BeizeObjectValue result = BeizeObjectValue();
            result.set(matchKey, BeizeNumberValue(match));
            result.setNamedProperty('item', item);
            results.add(result);
          }
          results.sort((final BeizeObjectValue a, final BeizeObjectValue b) {
            final BeizeNumberValue distanceA = a.get(matchKey).cast();
            final BeizeNumberValue distanceB = b.get(matchKey).cast();
            return distanceA.value.compareTo(distanceB.value);
          });
          return BeizeListValue(results);
        },
      ),
    );
    return value;
  }

  // NOTE: thank you chatgpt
  static int calculateLevenshteinDistance(final String a, final String b) {
    final List<int> distances =
        List<int>.generate(b.length + 1, (final int i) => i);
    for (int i = 1; i <= a.length; i++) {
      int previousDistance = distances[0];
      distances[0] = i;
      for (int j = 1; j <= b.length; j++) {
        final int currentDistance = distances[j];
        final int cost = (a[i - 1] == b[j - 1]) ? 0 : 1;
        distances[j] = _min3(
          distances[j] + 1, // deletion
          distances[j - 1] + 1, // insertion
          previousDistance + cost, // substitution
        );
        previousDistance = currentDistance;
      }
    }
    return distances[b.length];
  }

  static int _min3(final int a, final int b, final int c) => min(min(a, b), c);
}

class _FuzzySearchKey {
  const _FuzzySearchKey({
    required this.getter,
    required this.weight,
  });

  final BeizeValue getter;
  final double weight;
}
