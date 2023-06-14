import 'dart:math';
import 'package:baize_vm/baize_vm.dart';
import '../converter/exports.dart';

abstract class FuzzySearchBindings {
  static void bind(final BaizeNamespace namespace) {
    final BaizeObjectValue value = BaizeObjectValue();
    value.setNamedProperty(
      'new',
      BaizeNativeFunctionValue.sync(
        (final BaizeNativeFunctionCall call) {
          final BaizeObjectValue options = call.argumentAt(0);
          final BaizeListValue items = options.getNamedProperty('items');
          final BaizeListValue keys = options.getNamedProperty('keys');
          return newClient(
            items: items.elements,
            keys: keys.elements.map(
              (final BaizeValue x) {
                final BaizeObjectValue casted = x.cast();
                return _FuzzySearchKey(
                  getter: casted.getNamedProperty('getter'),
                  weight: casted
                      .getNamedProperty('weight')
                      .cast<BaizeNumberValue>()
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

  static BaizeValue newClient({
    required final List<BaizeValue> items,
    required final List<_FuzzySearchKey> keys,
  }) {
    final BaizeObjectValue value = BaizeObjectValue();
    value.setNamedProperty(
      'search',
      BaizeNativeFunctionValue.async(
        (final BaizeNativeFunctionCall call) async {
          final BaizeStringValue terms = call.argumentAt(0);
          final List<BaizeObjectValue> results = <BaizeObjectValue>[];
          final BaizeStringValue matchKey = BaizeStringValue('match');
          for (final BaizeValue item in items) {
            double match = 0;
            for (final _FuzzySearchKey key in keys) {
              final BaizeValue againstValue = await call.frame.callValue(
                key.getter,
                <BaizeValue>[item],
              ).unwrapUnsafe();
              final String against = againstValue.kToString();
              final int distance = calculateLevenshteinDistance(
                terms.value,
                against,
              );
              match += distance * key.weight;
            }
            final BaizeObjectValue result = BaizeObjectValue();
            result.set(matchKey, BaizeNumberValue(match));
            result.setNamedProperty('item', item);
            results.add(result);
          }
          results.sort((final BaizeObjectValue a, final BaizeObjectValue b) {
            final BaizeNumberValue distanceA = a.get(matchKey).cast();
            final BaizeNumberValue distanceB = b.get(matchKey).cast();
            return distanceA.value.compareTo(distanceB.value);
          });
          return BaizeListValue(results);
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

  final BaizeValue getter;
  final double weight;
}
