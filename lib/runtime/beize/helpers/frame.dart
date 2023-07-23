import 'package:beize_vm/beize_vm.dart';

extension TenkaRuntimeBeizeCallFrameUtils on BeizeCallFrame {
  Future<BeizeValue> callValueAsyncUnwrapUnsafe(
    final BeizeValue value,
    final List<BeizeValue> arguments,
  ) async {
    final BeizeValue result = callValue(value, arguments).unwrapUnsafe();
    if (result is! BeizeUnawaitedValue) {
      return result;
    }
    return result.execute(this).unwrapUnsafe();
  }
}
