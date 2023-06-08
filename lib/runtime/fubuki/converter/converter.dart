import 'package:fubuki_vm/fubuki_vm.dart';
import '../../instance.dart';

abstract class TenkaFubukiConvertable<T> {
  TenkaFubukiConvertable(this.converter);

  final TenkaFubukiConverter converter;

  T convert(
    final FubukiCallFrame frame,
    final FubukiValue value,
  );

  List<T> convertMany(
    final FubukiCallFrame frame,
    final FubukiValue value,
  ) {
    final FubukiListValue casted = value.cast();
    return casted.elements
        .map((final FubukiValue x) => convert(frame, x))
        .toList();
  }

  T? maybeConvert(
    final FubukiCallFrame frame,
    final FubukiValue value,
  ) {
    if (value is FubukiNullValue) return null;
    return convert(frame, value);
  }
}

class TenkaFubukiConverter {
  TenkaFubukiConverter(this.runtime);

  final TenkaRuntimeInstance runtime;

  static const String kExtractor = 'extractor';
  static const String kDefaultLocale = 'defaultLocale';
  static const String kSearch = 'search';
  static const String kGetInfo = 'getInfo';
  static const String kGetSource = 'getSource';
  static const String kGetChapter = 'getChapter';
  static const String kGetPage = 'getPage';
  static const String kTitle = 'title';
  static const String kUrl = 'url';
  static const String kLocale = 'locale';
  static const String kEpisode = 'episode';
  static const String kEpisodes = 'episodes';
  static const String kStreams = 'streams';
  static const String kSubtitles = 'subtitles';
  static const String kHeaders = 'headers';
  static const String kAvailableLocales = 'availableLocales';
  static const String kThumbnail = 'thumbnail';
  static const String kQuality = 'quality';
  static const String kChapter = 'chapter';
  static const String kVolume = 'volume';
  static const String kChapters = 'chapters';
}

extension TenkaFubukiConverterUtils on FubukiPrimitiveObjectValue {
  T getNamedProperty<T extends FubukiValue>(final String name) =>
      get(FubukiStringValue(name)).cast();

  void setNamedProperty(
    final String name,
    final FubukiValue value,
  ) =>
      set(FubukiStringValue(name), value);
}
