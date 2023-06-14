import 'package:baize_vm/baize_vm.dart';
import 'exports.dart';

class TenkaBaizeHeadersConvertable
    extends TenkaBaizeConvertable<Map<String, String>> {
  TenkaBaizeHeadersConvertable(super.converter);

  @override
  Map<String, String> convert(
    final BaizeCallFrame frame,
    final BaizeValue value,
  ) {
    final BaizePrimitiveObjectValue casted = value.cast();
    final Map<String, String> result = <String, String>{};
    for (final MapEntry<BaizeValue, BaizeValue> x in casted.entries()) {
      final BaizeStringValue key = x.key.cast();
      final BaizeStringValue value = x.value.cast();
      result[key.value] = value.value;
    }
    return result;
  }
}

extension TenkaBaizeHeadersConverter on TenkaBaizeConverter {
  TenkaBaizeHeadersConvertable get headers =>
      TenkaBaizeHeadersConvertable(this);
}
