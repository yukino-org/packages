import 'package:baize_vm/baize_vm.dart';
import 'package:tenka/tenka.dart';

class TenkaBaizePageInfoConvertable extends TenkaBaizeConvertable<PageInfo> {
  TenkaBaizePageInfoConvertable(super.converter);

  @override
  PageInfo convert(
    final BaizeCallFrame frame,
    final BaizeValue value,
  ) {
    final BaizePrimitiveObjectValue casted = value.cast();
    final BaizeStringValue url =
        casted.getNamedProperty(TenkaBaizeConverter.kUrl);
    final BaizeValue locale =
        casted.getNamedProperty(TenkaBaizeConverter.kLocale);

    return PageInfo(
      url: url.value,
      locale: converter.locale.convert(frame, locale),
    );
  }
}

extension TenkaBaizePageInfoConverter on TenkaBaizeConverter {
  TenkaBaizePageInfoConvertable get pageInfo =>
      TenkaBaizePageInfoConvertable(this);
}
