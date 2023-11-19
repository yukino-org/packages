import 'package:utilx/utilx.dart';
import '../metadata/exports.dart';

class TenkaStore {
  const TenkaStore({
    required this.baseUrl,
    required this.modules,
    required this.builtAt,
  });

  factory TenkaStore.fromJson(final JsonMap json) => TenkaStore(
        baseUrl: json['baseUrl'] as String,
        modules: castJsonMap<String, JsonMap>(json['modules']).map(
          (final String i, final JsonMap x) => MapEntry<String, TenkaMetadata>(
            i,
            TenkaMetadata.fromJson(x),
          ),
        ),
        builtAt: DateTime.parse(json['builtAt'] as String),
      );

  final String baseUrl;
  final Map<String, TenkaMetadata> modules;
  final DateTime builtAt;

  JsonMap toJson() => <dynamic, dynamic>{
        'baseUrl': baseUrl,
        'modules': modules.map(
          (final String i, final TenkaMetadata x) =>
              MapEntry<String, JsonMap>(i, x.toJson()),
        ),
        'builtAt': builtAt.toIso8601String(),
      };
}
