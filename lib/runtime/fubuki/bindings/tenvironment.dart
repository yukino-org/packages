import 'package:fubuki_vm/fubuki_vm.dart';
import 'package:tenka/tenka.dart';

abstract class TEnvironmentBindings {
  static void bind(final FubukiNamespace namespace) {
    final FubukiObjectValue value = FubukiObjectValue();
    value.set(
      FubukiStringValue('isDebug'),
      FubukiNativeFunctionValue.sync((final _) => FubukiBooleanValue(isDebug)),
    );
    namespace.declare('TEnvironment', value);
  }

  static bool get isDebug => TenkaInternals.isDebug;
}
