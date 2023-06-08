import 'package:utilx/locale.dart';
import 'package:utilx/utils.dart';

class EpisodeSubtitle {
  const EpisodeSubtitle({
    required this.url,
    required this.headers,
    required this.locale,
  });

  factory EpisodeSubtitle.fromJson(final JsonMap json) => EpisodeSubtitle(
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
