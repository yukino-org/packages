import 'package:fubuki_vm/fubuki_vm.dart';
import 'package:utilx/locale.dart';
import 'exports.dart';

class TenkaFubukiLocaleConvertable extends TenkaFubukiConvertable<Locale> {
  TenkaFubukiLocaleConvertable(super.converter);

  @override
  Locale convert(final FubukiValue value) {
    final FubukiStringValue casted = value.cast();
    return Locale.parse(casted.value);
  }
}

extension TenkaFubukiLocaleConverter on TenkaFubukiConverter {
  TenkaFubukiLocaleConvertable get locale => TenkaFubukiLocaleConvertable(this);
}
