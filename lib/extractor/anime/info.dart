import 'package:utilx/locale.dart';
import 'package:utilx/utilx.dart';
import '../base/image_describer.dart';
import 'episode/info.dart';

class AnimeInfo {
  AnimeInfo({
    required this.title,
    required this.url,
    required final List<EpisodeInfo> episodes,
    required this.locale,
    required this.availableLocales,
    this.thumbnail,
  }) : episodes = ListUtils.tryArrange(
          episodes,
          (final EpisodeInfo x) => x.episode,
        );

  factory AnimeInfo.fromJson(final JsonMap json) => AnimeInfo(
        title: json['title'] as String,
        url: json['url'] as String,
        episodes: castList<JsonMap>(json['episodes'])
            .map((final JsonMap x) => EpisodeInfo.fromJson(x))
            .toList(),
        thumbnail: json['thumbnail'] != null
            ? ImageDescriber.fromJson(json['thumbnail'] as JsonMap)
            : null,
        locale: Locale.parse(json['locale'] as String),
        availableLocales: castList<String>(json['availableLocales'])
            .map((final String x) => Locale.parse(x))
            .toList(),
      );

  final String title;
  final String url;
  final List<EpisodeInfo> episodes;
  final ImageDescriber? thumbnail;
  final Locale locale;
  final List<Locale> availableLocales;

  JsonMap toJson() => <dynamic, dynamic>{
        'title': title,
        'url': url,
        'thumbnail': thumbnail?.toJson(),
        'episodes': episodes.map((final EpisodeInfo x) => x.toJson()).toList(),
        'locale': locale.code,
        'availableLocales':
            availableLocales.map((final Locale x) => x.code).toList(),
      };
}
