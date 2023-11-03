import 'package:beize_vm/beize_vm.dart';
import 'package:tenka/tenka.dart';

class TenkaRuntimeInstance {
  TenkaRuntimeInstance(this.program);

  final BeizeProgramConstant program;

  late final BeizeVM vm =
      BeizeVM(program, BeizeVMOptions(disablePrint: !TenkaInternals.isDebug));
  late final TenkaBeizeConverter converter = TenkaBeizeConverter(this);

  Future<void> initialize() async {
    TenkaBeizeBindings.bind(vm.globalNamespace);
    await vm.run();
  }

  Future<AnimeExtractor> getAnimeExtractor() async {
    final BeizeValue result = getExtractorValue();
    return converter.animeExtractor.convert(vm.topFrame, result);
  }

  Future<MangaExtractor> getMangaExtractor() async {
    final BeizeValue result = getExtractorValue();
    return converter.mangaExtractor.convert(vm.topFrame, result);
  }

  BeizeValue getExtractorValue() => vm.modules[0]!.namespace.lookup(kExtractor);

  static const String kExtractor = 'extractor';
  static const String kDefaultLocale = 'defaultLocale';
  static const String kSearch = 'search';
  static const String kGetInfo = 'getInfo';
  static const String kGetSources = 'getSources';
  static const String kGetChapter = 'getChapter';
  static const String kGetPage = 'getPage';
  static const String kTitle = 'title';
  static const String kUrl = 'url';
  static const String kLocale = 'locale';
  static const String kEpisode = 'episode';
  static const String kEpisodes = 'episodes';
  static const String kHeaders = 'headers';
  static const String kAvailableLocales = 'availableLocales';
  static const String kThumbnail = 'thumbnail';
  static const String kQuality = 'quality';
  static const String kChapter = 'chapter';
  static const String kVolume = 'volume';
  static const String kChapters = 'chapters';
}
