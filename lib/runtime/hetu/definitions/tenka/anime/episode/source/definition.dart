import '../../../../../model.dart';
import 'binding.dart';

final HetuHelperClass hEpisodeSourceClass = HetuHelperClass(
  definition: EpisodeSourceClassBinding(),
  declaration: '''
external class EpisodeSource {
  /// ({
  ///   url: string,
  ///   quality: string,
  ///   headers: string,
  ///   locale: Locale,
  /// }) => EpisodeSource;
  construct({ url, quality, headers, locale });

  /// string
  get url;
  
  /// string
  get quality;
  
  /// Map<string, string>
  get headers;
  
  /// string
  get locale;

  /// () => Map<dynamic, dynamic>
  fun toJson();
}
      '''
      .trim(),
);