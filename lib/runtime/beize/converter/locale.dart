import 'package:beize_vm/beize_vm.dart';
import 'package:utilx/locale.dart';
import 'exports.dart';

class TenkaBeizeLocaleConvertable extends TenkaBeizeConvertable<Locale> {
  TenkaBeizeLocaleConvertable(super.converter);

  @override
  Locale convert(
    final BeizeCallFrame frame,
    final BeizeValue value,
  ) {
    final BeizeStringValue casted = value.cast();
    return Locale.parse(casted.value);
  }
}

extension TenkaBeizeLocaleConverter on TenkaBeizeConverter {
  TenkaBeizeLocaleConvertable get locale => TenkaBeizeLocaleConvertable(this);
}
