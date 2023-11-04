import 'package:utilx/locale.dart';
import 'package:utilx/utilx.dart';

class PageInfo {
  const PageInfo({
    required this.url,
    required this.locale,
  });

  factory PageInfo.fromJson(final JsonMap json) => PageInfo(
        url: json['url'] as String,
        locale: Locale.parse(json['locale'] as String),
      );

  final String url;
  final Locale locale;

  JsonMap toJson() => <dynamic, dynamic>{
        'url': url,
        'locale': locale.code,
      };
}
