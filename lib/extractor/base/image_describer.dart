import 'package:utilx/utils.dart';

class ImageDescriber {
  const ImageDescriber({
    required this.url,
    this.headers = const <String, String>{},
  });

  factory ImageDescriber.fromJson(final JsonMap json) => ImageDescriber(
        url: json['url'] as String,
        headers: castJsonMap(json['headers']),
      );

  final String url;
  final Map<String, String> headers;

  JsonMap toJson() => <dynamic, dynamic>{
        'url': url,
        'headers': headers,
      };
}
