import 'package:utilx/locale.dart';
import 'package:utilx/utilx.dart';

class EpisodeInfo {
  const EpisodeInfo({
    required this.episode,
    required this.url,
    required this.locale,
  });

  factory EpisodeInfo.fromJson(final JsonMap json) => EpisodeInfo(
        episode: json['episode'] as String,
        url: json['url'] as String,
        locale: Locale.parse(json['locale'] as String),
      );

  final String episode;
  final String url;
  final Locale locale;

  JsonMap toJson() => <dynamic, dynamic>{
        'episode': episode,
        'url': url,
        'locale': locale.code,
      };
}
