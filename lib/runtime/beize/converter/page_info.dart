import 'package:beize_vm/beize_vm.dart';
import 'package:tenka/tenka.dart';

class TenkaBeizePageInfoConvertable extends TenkaBeizeConvertable<PageInfo> {
  TenkaBeizePageInfoConvertable(super.converter);

  @override
  PageInfo convert(
    final BeizeCallFrame frame,
    final BeizeValue value,
  ) {
    final BeizePrimitiveObjectValue casted = value.cast();
    final BeizeStringValue url =
        casted.getNamedProperty(TenkaBeizeConverter.kUrl);
    final BeizeValue locale =
        casted.getNamedProperty(TenkaBeizeConverter.kLocale);

    return PageInfo(
      url: url.value,
      locale: converter.locale.convert(frame, locale),
    );
  }
}

extension TenkaBeizePageInfoConverter on TenkaBeizeConverter {
  TenkaBeizePageInfoConvertable get pageInfo =>
      TenkaBeizePageInfoConvertable(this);
}
