import 'package:baize_vm/baize_vm.dart';
import '../../instance.dart';

abstract class TenkaBaizeConvertable<T> {
  TenkaBaizeConvertable(this.converter);

  final TenkaBaizeConverter converter;

  T convert(
    final BaizeCallFrame frame,
    final BaizeValue value,
  );

  List<T> convertMany(
    final BaizeCallFrame frame,
    final BaizeValue value,
  ) {
    final BaizeListValue casted = value.cast();
    return casted.elements
        .map((final BaizeValue x) => convert(frame, x))
        .toList();
  }

  T? maybeConvert(
    final BaizeCallFrame frame,
    final BaizeValue value,
  ) {
    if (value is BaizeNullValue) return null;
    return convert(frame, value);
  }
}

class TenkaBaizeConverter {
  TenkaBaizeConverter(this.runtime);

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

extension TenkaBaizeConverterUtils on BaizePrimitiveObjectValue {
  T getNamedProperty<T extends BaizeValue>(final String name) =>
      get(BaizeStringValue(name)).cast();

  void setNamedProperty(
    final String name,
    final BaizeValue value,
  ) =>
      set(BaizeStringValue(name), value);
}
