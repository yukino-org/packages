import 'package:utilx/utilx.dart';
import '../metadata/exports.dart';

class TenkaStore {
  const TenkaStore({
    required this.baseURL,
    required this.modules,
    required this.builtAt,
  });

  factory TenkaStore.fromJson(final JsonMap json) => TenkaStore(
        baseURL: json['baseURL'] as String,
        modules: castJsonMap<String, JsonMap>(json['modules']).map(
          (final String i, final JsonMap x) => MapEntry<String, TenkaMetadata>(
            i,
            TenkaMetadata.fromJson(x),
          ),
        ),
        builtAt: DateTime.parse(json['builtAt'] as String),
      );

  final String baseURL;
  final Map<String, TenkaMetadata> modules;
  final DateTime builtAt;

  JsonMap toJson() => <dynamic, dynamic>{
        'baseURL': baseURL,
        'modules': modules.map(
          (final String i, final TenkaMetadata x) =>
              MapEntry<String, JsonMap>(i, x.toJson()),
        ),
        'builtAt': builtAt.toIso8601String(),
      };
}
