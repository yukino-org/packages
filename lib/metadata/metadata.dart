import 'package:utilx/utilx.dart';
import '../data/model.dart';
import 'version.dart';

enum TenkaType {
  anime,
  manga,
}

class TenkaMetadata {
  const TenkaMetadata({
    required this.id,
    required this.name,
    required this.type,
    required this.author,
    required this.source,
    required this.thumbnail,
    required this.nsfw,
    required this.version,
    required this.deprecated,
  });

  factory TenkaMetadata.fromJson(final JsonMap json) => TenkaMetadata(
        id: json['id'] as String,
        name: json['name'] as String,
        type: EnumUtils.find(TenkaType.values, json['type'] as String),
        author: json['author'] as String,
        source: TenkaDataSource.fromJson(
          json['source'] as JsonMap,
        ),
        thumbnail: TenkaDataSource.fromJson(
          json['thumbnail'] as JsonMap,
        ),
        nsfw: json['nsfw'] as bool,
        version: TenkaVersion.parse(json['version'] as String),
        deprecated: json['deprecated'] as bool,
      );

  final String id;
  final String name;
  final TenkaType type;
  final String author;
  final TenkaDataSource source;
  final TenkaDataSource thumbnail;
  final bool nsfw;
  final TenkaVersion version;
  final bool deprecated;

  JsonMap toJson() => <dynamic, dynamic>{
        'id': id,
        'name': name,
        'type': type.name,
        'author': author,
        'source': source.toJson(),
        'thumbnail': thumbnail.toJson(),
        'nsfw': nsfw,
        'version': version.toString(),
        'deprecated': deprecated,
      };
}
