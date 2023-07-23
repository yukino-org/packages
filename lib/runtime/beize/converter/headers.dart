import 'package:beize_vm/beize_vm.dart';
import 'exports.dart';

class TenkaBeizeHeadersConvertable
    extends TenkaBeizeConvertable<Map<String, String>> {
  TenkaBeizeHeadersConvertable(super.converter);

  @override
  Map<String, String> convert(
    final BeizeCallFrame frame,
    final BeizeValue value,
  ) {
    final BeizePrimitiveObjectValue casted = value.cast();
    final Map<String, String> result = <String, String>{};
    for (final MapEntry<BeizeValue, BeizeValue> x in casted.entries()) {
      final BeizeStringValue key = x.key.cast();
      final BeizeStringValue value = x.value.cast();
      result[key.value] = value.value;
    }
    return result;
  }
}

extension TenkaBeizeHeadersConverter on TenkaBeizeConverter {
  TenkaBeizeHeadersConvertable get headers =>
      TenkaBeizeHeadersConvertable(this);
}
