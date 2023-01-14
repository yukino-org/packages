import 'package:fubuki_vm/fubuki_vm.dart';
import 'package:tenka/tenka.dart';
import 'package:utilx/generated/locale.g.dart';

abstract class LanguagesBindings {
  static void bind(final FubukiNamespace namespace) {
    final FubukiObjectValue value = FubukiObjectValue();
    value.set(
      FubukiStringValue('isValid'),
      FubukiNativeFunctionValue.sync(
        (final FubukiNativeFunctionCall call) {
          final FubukiStringValue lang = call.argumentAt(0);
          return FubukiBooleanValue(
            LanguageUtils.nameCodeMap.containsKey(lang.value),
          );
        },
      ),
    );
    value.set(
      FubukiStringValue('all'),
      FubukiNativeFunctionValue.sync(
        (final _) => FubukiListValue(
          LanguageUtils.nameCodeMap.keys
              .map((final String x) => FubukiStringValue(x))
              .toList(),
        ),
      ),
    );
    namespace.declare('Languages', value);
  }

  static bool get isDebug => TenkaInternals.isDebug;
}
