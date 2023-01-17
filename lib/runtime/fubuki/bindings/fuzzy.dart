import 'dart:math';
import 'package:fubuki_vm/fubuki_vm.dart';
import '../converter/exports.dart';

abstract class FuzzySearchBindings {
  static void bind(final FubukiNamespace namespace) {
    final FubukiObjectValue value = FubukiObjectValue();
    value.setNamedProperty(
      'new',
      FubukiNativeFunctionValue.sync(
        (final FubukiNativeFunctionCall call) {
          final FubukiObjectValue options = call.argumentAt(0);
          final FubukiListValue items = options.getNamedProperty('items');
          final FubukiListValue keys = options.getNamedProperty('keys');
          return newClient(
            items: items.elements,
            keys: keys.elements.map(
              (final FubukiValue x) {
                final FubukiObjectValue casted = x.cast();
                return _FuzzySearchKey(
                  getter: casted.getNamedProperty('getter'),
                  weight: casted
                      .getNamedProperty('weight')
                      .cast<FubukiNumberValue>()
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

  static FubukiValue newClient({
    required final List<FubukiValue> items,
    required final List<_FuzzySearchKey> keys,
  }) {
    final FubukiObjectValue value = FubukiObjectValue();
    value.setNamedProperty(
      'search',
      FubukiNativeFunctionValue.async(
        (final FubukiNativeFunctionCall call) async {
          final FubukiStringValue terms = call.argumentAt(0);
          final List<FubukiObjectValue> results = <FubukiObjectValue>[];
          final FubukiStringValue matchKey = FubukiStringValue('match');
          for (final FubukiValue item in items) {
            double match = 0;
            for (final _FuzzySearchKey key in keys) {
              final FubukiValue againstValue = await call.frame.callValue(
                key.getter,
                <FubukiValue>[item],
              ).unwrapUnsafe();
              final String against = againstValue.kToString();
              final int distance = calculateLevenshteinDistance(
                terms.value,
                against,
              );
              match += distance * key.weight;
            }
            final FubukiObjectValue result = FubukiObjectValue();
            result.set(matchKey, FubukiNumberValue(match));
            result.setNamedProperty('item', item);
            results.add(result);
          }
          results.sort((final FubukiObjectValue a, final FubukiObjectValue b) {
            final FubukiNumberValue distanceA = a.get(matchKey).cast();
            final FubukiNumberValue distanceB = b.get(matchKey).cast();
            return distanceA.value.compareTo(distanceB.value);
          });
          return FubukiListValue(results);
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

  final FubukiValue getter;
  final double weight;
}
