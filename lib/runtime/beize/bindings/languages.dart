import 'package:beize_vm/beize_vm.dart';
import 'package:tenka/tenka.dart';
import 'package:utilx/locale.dart';

abstract class LanguagesBindings {
  static void bind(final BeizeNamespace namespace) {
    final BeizeObjectValue value = BeizeObjectValue();
    value.setNamedProperty(
      'isValid',
      BeizeNativeFunctionValue.sync(
        (final BeizeNativeFunctionCall call) {
          final BeizeStringValue lang = call.argumentAt(0);
          return BeizeBooleanValue(
            LocalesRepository.all.containsKey(lang.value),
          );
        },
      ),
    );
    value.setNamedProperty(
      'all',
      BeizeNativeFunctionValue.sync(
        (final _) => BeizeListValue(
          LocalesRepository.all.keys
              .map((final String x) => BeizeStringValue(x))
              .toList(),
        ),
      ),
    );
    namespace.declare('Languages', value);
  }

  static bool get isDebug => TenkaInternals.isDebug;
}
