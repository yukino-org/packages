import 'package:beize_vm/beize_vm.dart';
import 'exports.dart';

class TenkaBeizeNullableStringConvertable
    extends TenkaBeizeConvertable<String?> {
  TenkaBeizeNullableStringConvertable(super.converter);

  @override
  String? convert(
    final BeizeCallFrame frame,
    final BeizeValue value,
  ) {
    if (value is BeizeNullValue) return null;
    final BeizeStringValue casted = value.cast();
    return casted.value;
  }
}

extension TenkaBeizeNullableStringConverter on TenkaBeizeConverter {
  TenkaBeizeNullableStringConvertable get nullableString =>
      TenkaBeizeNullableStringConvertable(this);
}
