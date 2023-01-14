import 'package:fubuki_vm/fubuki_vm.dart';
import 'exports.dart';

class TenkaFubukiNullableStringConvertable
    extends TenkaFubukiConvertable<String?> {
  TenkaFubukiNullableStringConvertable(super.converter);

  @override
  String? convert(final FubukiValue value) {
    if (value is FubukiNullValue) return null;
    final FubukiStringValue casted = value.cast();
    return casted.value;
  }
}

extension TenkaFubukiNullableStringConverter on TenkaFubukiConverter {
  TenkaFubukiNullableStringConvertable get nullableString =>
      TenkaFubukiNullableStringConvertable(this);
}
