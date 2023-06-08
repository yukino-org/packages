import 'package:utilx/locale.dart';
import 'quality.dart';

class EpisodeSource {
  const EpisodeSource({
    required this.url,
    required this.quality,
    required this.headers,
    required this.locale,
  });

  factory EpisodeSource.fromJson(final Map<dynamic, dynamic> json) =>
      EpisodeSource(
        url: json['url'] as String,
        headers:
            (json['headers'] as Map<dynamic, dynamic>).cast<String, String>(),
        quality: Quality.parse(json['quality'] as String),
        locale: Locale.parse(json['locale'] as String),
      );

  final String url;
  final Quality quality;
  final Map<String, String> headers;
  final Locale locale;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'quality': quality.code,
        'url': url,
        'headers': headers,
        'locale': locale.toCodeString(),
      };
}
