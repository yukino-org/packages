import 'package:beize_vm/beize_vm.dart';
import '../../instance.dart';

abstract class TenkaBeizeConvertable<T> {
  TenkaBeizeConvertable(this.converter);

  final TenkaBeizeConverter converter;

  T convert(
    final BeizeCallFrame frame,
    final BeizeValue value,
  );

  List<T> convertMany(
    final BeizeCallFrame frame,
    final BeizeValue value,
  ) {
    final BeizeListValue casted = value.cast();
    return casted.elements
        .map((final BeizeValue x) => convert(frame, x))
        .toList();
  }

  T? maybeConvert(
    final BeizeCallFrame frame,
    final BeizeValue value,
  ) {
    if (value is BeizeNullValue) return null;
    return convert(frame, value);
  }
}

class TenkaBeizeConverter {
  TenkaBeizeConverter(this.runtime);

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

extension TenkaBeizeConverterUtils on BeizePrimitiveObjectValue {
  T getNamedProperty<T extends BeizeValue>(final String name) =>
      get(BeizeStringValue(name)).cast();

  void setNamedProperty(
    final String name,
    final BeizeValue value,
  ) =>
      set(BeizeStringValue(name), value);
}
