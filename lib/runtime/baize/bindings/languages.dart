import 'package:baize_vm/baize_vm.dart';
import 'package:tenka/tenka.dart';
import 'package:utilx/generated/locale.g.dart';

abstract class LanguagesBindings {
  static void bind(final BaizeNamespace namespace) {
    final BaizeObjectValue value = BaizeObjectValue();
    value.setNamedProperty(
      'isValid',
      BaizeNativeFunctionValue.sync(
        (final BaizeNativeFunctionCall call) {
          final BaizeStringValue lang = call.argumentAt(0);
          return BaizeBooleanValue(
            LanguageUtils.nameCodeMap.containsKey(lang.value),
          );
        },
      ),
    );
    value.setNamedProperty(
      'all',
      BaizeNativeFunctionValue.sync(
        (final _) => BaizeListValue(
          LanguageUtils.nameCodeMap.keys
              .map((final String x) => BaizeStringValue(x))
              .toList(),
        ),
      ),
    );
    namespace.declare('Languages', value);
  }

  static bool get isDebug => TenkaInternals.isDebug;
}
