import 'package:beize_vm/beize_vm.dart';
import 'package:tenka/tenka.dart';

class TenkaBeizeSearchInfoConvertable
    extends TenkaBeizeConvertable<SearchInfo> {
  TenkaBeizeSearchInfoConvertable(super.converter);

  @override
  SearchInfo convert(
    final BeizeCallFrame frame,
    final BeizeValue value,
  ) {
    final BeizePrimitiveObjectValue casted = value.cast();
    final BeizeStringValue title =
        casted.getNamedProperty(TenkaBeizeConverter.kTitle);
    final BeizeStringValue url =
        casted.getNamedProperty(TenkaBeizeConverter.kUrl);
    final BeizeValue locale =
        casted.getNamedProperty(TenkaBeizeConverter.kLocale);
    final BeizeValue thumbnail =
        casted.getNamedProperty(TenkaBeizeConverter.kThumbnail);

    return SearchInfo(
      title: title.value,
      url: url.value,
      locale: converter.locale.convert(frame, locale),
      thumbnail: converter.imageDescriber.maybeConvert(frame, thumbnail),
    );
  }
}

extension TenkaBeizeSearchInfoConverter on TenkaBeizeConverter {
  TenkaBeizeSearchInfoConvertable get searchInfo =>
      TenkaBeizeSearchInfoConvertable(this);
}
