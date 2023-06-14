import 'package:baize_vm/baize_vm.dart';
import 'exports.dart';

class TenkaBaizeNullableStringConvertable
    extends TenkaBaizeConvertable<String?> {
  TenkaBaizeNullableStringConvertable(super.converter);

  @override
  String? convert(
    final BaizeCallFrame frame,
    final BaizeValue value,
  ) {
    if (value is BaizeNullValue) return null;
    final BaizeStringValue casted = value.cast();
    return casted.value;
  }
}

extension TenkaBaizeNullableStringConverter on TenkaBaizeConverter {
  TenkaBaizeNullableStringConvertable get nullableString =>
      TenkaBaizeNullableStringConvertable(this);
}
