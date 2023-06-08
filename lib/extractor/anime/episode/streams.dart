import 'package:utilx/locale.dart';
import 'package:utilx/utils.dart';
import 'quality.dart';

class EpisodeStream {
  const EpisodeStream({
    required this.url,
    required this.quality,
    required this.headers,
    required this.locale,
  });

  factory EpisodeStream.fromJson(final JsonMap json) => EpisodeStream(
        url: json['url'] as String,
        headers: castJsonMap(json['headers']),
        quality: Quality.parse(json['quality'] as String),
        locale: Locale.parse(json['locale'] as String),
      );

  final String url;
  final Quality quality;
  final Map<String, String> headers;
  final Locale locale;

  JsonMap toJson() => <dynamic, dynamic>{
        'quality': quality.code,
        'url': url,
        'headers': headers,
        'locale': locale.toCodeString(),
      };
}
