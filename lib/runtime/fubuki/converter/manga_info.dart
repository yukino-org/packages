import 'package:fubuki_vm/fubuki_vm.dart';
import 'package:tenka/tenka.dart';
import 'package:tenka_runtime/runtime/fubuki/converter/chapter_info.dart';
import 'exports.dart';

class TenkaFubukiMangaInfoConvertable
    extends TenkaFubukiConvertable<MangaInfo> {
  TenkaFubukiMangaInfoConvertable(super.converter);

  @override
  MangaInfo convert(final FubukiValue value) {
    final FubukiPrimitiveObjectValue casted = value.cast();
    final FubukiStringValue title =
        casted.getNamedProperty(TenkaFubukiConverter.kTitle);
    final FubukiStringValue url =
        casted.getNamedProperty(TenkaFubukiConverter.kUrl);
    final FubukiValue chapters =
        casted.getNamedProperty(TenkaFubukiConverter.kChapters);
    final FubukiStringValue locale =
        casted.getNamedProperty(TenkaFubukiConverter.kLocale);
    final FubukiListValue availableLocales =
        casted.getNamedProperty(TenkaFubukiConverter.kAvailableLocales);
    final FubukiListValue thumbnail =
        casted.getNamedProperty(TenkaFubukiConverter.kThumbnail);

    return MangaInfo(
      title: title.value,
      url: url.value,
      chapters: converter.chapterInfo.convertMany(chapters),
      locale: converter.locale.convert(locale),
      availableLocales: converter.locale.convertMany(availableLocales),
      thumbnail: converter.imageDescriber.maybeConvert(thumbnail),
    );
  }
}

extension TenkaFubukiMangaInfoConverter on TenkaFubukiConverter {
  TenkaFubukiMangaInfoConvertable get mangaInfo =>
      TenkaFubukiMangaInfoConvertable(this);
}
