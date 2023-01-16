import 'package:fubuki_vm/fubuki_vm.dart';
import 'exports.dart';

class TenkaFubukiHeadersConvertable
    extends TenkaFubukiConvertable<Map<String, String>> {
  TenkaFubukiHeadersConvertable(super.converter);

  @override
  Map<String, String> convert(
    final FubukiCallFrame frame,
    final FubukiValue value,
  ) {
    final FubukiPrimitiveObjectValue casted = value.cast();
    final Map<String, String> result = <String, String>{};
    for (final MapEntry<FubukiValue, FubukiValue> x in casted.entries()) {
      final FubukiStringValue key = x.key.cast();
      final FubukiStringValue value = x.value.cast();
      result[key.value] = value.value;
    }
    return result;
  }
}

extension TenkaFubukiHeadersConverter on TenkaFubukiConverter {
  TenkaFubukiHeadersConvertable get headers =>
      TenkaFubukiHeadersConvertable(this);
}
