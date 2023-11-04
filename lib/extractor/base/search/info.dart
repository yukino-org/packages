import 'package:utilx/locale.dart';
import 'package:utilx/utilx.dart';
import '../image_describer.dart';

typedef SearchFn = Future<List<SearchInfo>> Function(
  String terms,
  Locale locale,
);

class SearchInfo {
  const SearchInfo({
    required this.title,
    required this.url,
    required this.locale,
    this.thumbnail,
  });

  factory SearchInfo.fromJson(final JsonMap json) => SearchInfo(
        title: json['title'] as String,
        url: json['url'] as String,
        thumbnail: json['thumbnail'] != null
            ? ImageDescriber.fromJson(json['thumbnail'] as JsonMap)
            : null,
        locale: Locale.parse(json['locale'] as String),
      );

  final String title;
  final String url;
  final ImageDescriber? thumbnail;
  final Locale locale;

  JsonMap toJson() => <dynamic, dynamic>{
        'title': title,
        'url': url,
        'thumbnail': thumbnail?.toJson(),
        'locale': locale.code,
      };
}
