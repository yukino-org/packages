import 'package:utilx/locale.dart';
import 'package:utilx/utils.dart';

class EpisodeSubtitles {
  const EpisodeSubtitles({
    required this.url,
    required this.headers,
    required this.locale,
  });

  factory EpisodeSubtitles.fromJson(final JsonMap json) => EpisodeSubtitles(
        url: json['url'] as String,
        headers: castJsonMap(json['headers']),
        locale: Locale.parse(json['locale'] as String),
      );

  final String url;
  final Map<String, String> headers;
  final Locale locale;

  JsonMap toJson() => <dynamic, dynamic>{
        'url': url,
        'headers': headers,
        'locale': locale.toCodeString(),
      };
}
