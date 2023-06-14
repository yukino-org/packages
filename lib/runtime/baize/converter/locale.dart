import 'package:baize_vm/baize_vm.dart';
import 'package:utilx/locale.dart';
import 'exports.dart';

class TenkaBaizeLocaleConvertable extends TenkaBaizeConvertable<Locale> {
  TenkaBaizeLocaleConvertable(super.converter);

  @override
  Locale convert(
    final BaizeCallFrame frame,
    final BaizeValue value,
  ) {
    final BaizeStringValue casted = value.cast();
    return Locale.parse(casted.value);
  }
}

extension TenkaBaizeLocaleConverter on TenkaBaizeConverter {
  TenkaBaizeLocaleConvertable get locale => TenkaBaizeLocaleConvertable(this);
}
