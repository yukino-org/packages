import 'package:beize_vm/beize_vm.dart';
import 'package:tenka/tenka.dart';

abstract class TEnvironmentBindings {
  static void bind(final BeizeNamespace namespace) {
    final BeizeObjectValue value = BeizeObjectValue();
    value.setNamedProperty(
      'isDebug',
      BeizeNativeFunctionValue.sync((final _) => BeizeBooleanValue(isDebug)),
    );
    namespace.declare('TEnvironment', value);
  }

  static bool get isDebug => TenkaInternals.isDebug;
}
