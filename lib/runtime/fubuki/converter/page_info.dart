import 'package:fubuki_vm/fubuki_vm.dart';
import 'package:tenka/tenka.dart';

class TenkaFubukiPageInfoConvertable extends TenkaFubukiConvertable<PageInfo> {
  TenkaFubukiPageInfoConvertable(super.converter);

  @override
  PageInfo convert(
    final FubukiCallFrame frame,
    final FubukiValue value,
  ) {
    final FubukiPrimitiveObjectValue casted = value.cast();
    final FubukiStringValue url =
        casted.getNamedProperty(TenkaFubukiConverter.kUrl);
    final FubukiValue locale =
        casted.getNamedProperty(TenkaFubukiConverter.kLocale);

    return PageInfo(
      url: url.value,
      locale: converter.locale.convert(frame, locale),
    );
  }
}

extension TenkaFubukiPageInfoConverter on TenkaFubukiConverter {
  TenkaFubukiPageInfoConvertable get pageInfo =>
      TenkaFubukiPageInfoConvertable(this);
}
