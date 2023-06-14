import 'package:baize_vm/baize_vm.dart';
import 'package:tenka/tenka.dart';

class TenkaBaizeSearchInfoConvertable
    extends TenkaBaizeConvertable<SearchInfo> {
  TenkaBaizeSearchInfoConvertable(super.converter);

  @override
  SearchInfo convert(
    final BaizeCallFrame frame,
    final BaizeValue value,
  ) {
    final BaizePrimitiveObjectValue casted = value.cast();
    final BaizeStringValue title =
        casted.getNamedProperty(TenkaBaizeConverter.kTitle);
    final BaizeStringValue url =
        casted.getNamedProperty(TenkaBaizeConverter.kUrl);
    final BaizeValue locale =
        casted.getNamedProperty(TenkaBaizeConverter.kLocale);
    final BaizeValue thumbnail =
        casted.getNamedProperty(TenkaBaizeConverter.kThumbnail);

    return SearchInfo(
      title: title.value,
      url: url.value,
      locale: converter.locale.convert(frame, locale),
      thumbnail: converter.imageDescriber.maybeConvert(frame, thumbnail),
    );
  }
}

extension TenkaBaizeSearchInfoConverter on TenkaBaizeConverter {
  TenkaBaizeSearchInfoConvertable get searchInfo =>
      TenkaBaizeSearchInfoConvertable(this);
}
