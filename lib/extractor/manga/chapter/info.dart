import 'package:utilx/locale.dart';
import 'package:utilx/utilx.dart';

class ChapterInfo {
  const ChapterInfo({
    required this.chapter,
    required this.url,
    required this.locale,
    this.title,
    this.volume,
  });

  factory ChapterInfo.fromJson(final JsonMap json) => ChapterInfo(
        title: json['title'] as String?,
        url: json['url'] as String,
        volume: json['volume'] as String?,
        chapter: json['chapter'] as String,
        locale: Locale.parse(json['locale'] as String),
      );

  final String? title;
  final String? volume;
  final String chapter;
  final String url;
  final Locale locale;

  JsonMap toJson() => <dynamic, dynamic>{
        'title': title,
        'volume': volume,
        'chapter': chapter,
        'url': url,
        'locale': locale.code,
      };
}
