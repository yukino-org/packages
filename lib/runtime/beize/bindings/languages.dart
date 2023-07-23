import 'package:beize_vm/beize_vm.dart';
import 'package:tenka/tenka.dart';
import 'package:utilx/generated/locale.g.dart';

abstract class LanguagesBindings {
  static void bind(final BeizeNamespace namespace) {
    final BeizeObjectValue value = BeizeObjectValue();
    value.setNamedProperty(
      'isValid',
      BeizeNativeFunctionValue.sync(
        (final BeizeNativeFunctionCall call) {
          final BeizeStringValue lang = call.argumentAt(0);
          return BeizeBooleanValue(
            LanguageUtils.nameCodeMap.containsKey(lang.value),
          );
        },
      ),
    );
    value.setNamedProperty(
      'all',
      BeizeNativeFunctionValue.sync(
        (final _) => BeizeListValue(
          LanguageUtils.nameCodeMap.keys
              .map((final String x) => BeizeStringValue(x))
              .toList(),
        ),
      ),
    );
    namespace.declare('Languages', value);
  }

  static bool get isDebug => TenkaInternals.isDebug;
}
