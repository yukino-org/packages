import 'package:baize_vm/baize_vm.dart';
import 'package:tenka/tenka.dart';

abstract class TEnvironmentBindings {
  static void bind(final BaizeNamespace namespace) {
    final BaizeObjectValue value = BaizeObjectValue();
    value.setNamedProperty(
      'isDebug',
      BaizeNativeFunctionValue.sync((final _) => BaizeBooleanValue(isDebug)),
    );
    namespace.declare('TEnvironment', value);
  }

  static bool get isDebug => TenkaInternals.isDebug;
}
