import 'package:fubuki_vm/fubuki_vm.dart';
import 'package:tenka/tenka.dart';
import 'exports.dart';

class TenkaFubukiSearchInfoConvertable
    extends TenkaFubukiConvertable<SearchInfo> {
  TenkaFubukiSearchInfoConvertable(super.converter);

  @override
  SearchInfo convert(final FubukiValue value) {
    final FubukiPrimitiveObjectValue casted = value.cast();
    final FubukiStringValue title =
        casted.getNamedProperty(TenkaFubukiConverter.kTitle);
    final FubukiStringValue url =
        casted.getNamedProperty(TenkaFubukiConverter.kUrl);
    final FubukiValue locale =
        casted.getNamedProperty(TenkaFubukiConverter.kLocale);
    final FubukiValue thumbnail =
        casted.getNamedProperty(TenkaFubukiConverter.kThumbnail);

    return SearchInfo(
      title: title.value,
      url: url.value,
      locale: converter.locale.convert(locale),
      thumbnail: converter.imageDescriber.maybeConvert(thumbnail),
    );
  }
}

extension TenkaFubukiSearchInfoConverter on TenkaFubukiConverter {
  TenkaFubukiSearchInfoConvertable get searchInfo =>
      TenkaFubukiSearchInfoConvertable(this);
}
