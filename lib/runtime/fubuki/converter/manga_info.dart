import 'package:fubuki_vm/fubuki_vm.dart';
import 'package:tenka/tenka.dart';

class TenkaFubukiMangaInfoConvertable
    extends TenkaFubukiConvertable<MangaInfo> {
  TenkaFubukiMangaInfoConvertable(super.converter);

  @override
  MangaInfo convert(
    final FubukiCallFrame frame,
    final FubukiValue value,
  ) {
    final FubukiPrimitiveObjectValue casted = value.cast();
    final FubukiStringValue title =
        casted.getNamedProperty(TenkaFubukiConverter.kTitle);
    final FubukiStringValue url =
        casted.getNamedProperty(TenkaFubukiConverter.kUrl);
    final FubukiValue chapters =
        casted.getNamedProperty(TenkaFubukiConverter.kChapters);
    final FubukiStringValue locale =
        casted.getNamedProperty(TenkaFubukiConverter.kLocale);
    final FubukiValue availableLocales =
        casted.getNamedProperty(TenkaFubukiConverter.kAvailableLocales);
    final FubukiValue thumbnail =
        casted.getNamedProperty(TenkaFubukiConverter.kThumbnail);

    return MangaInfo(
      title: title.value,
      url: url.value,
      chapters: converter.chapterInfo.convertMany(frame, chapters),
      locale: converter.locale.convert(frame, locale),
      availableLocales: converter.locale.convertMany(frame, availableLocales),
      thumbnail: converter.imageDescriber.maybeConvert(frame, thumbnail),
    );
  }
}

extension TenkaFubukiMangaInfoConverter on TenkaFubukiConverter {
  TenkaFubukiMangaInfoConvertable get mangaInfo =>
      TenkaFubukiMangaInfoConvertable(this);
}
