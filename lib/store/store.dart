import 'package:utilx/utilx.dart';
import '../metadata/exports.dart';

class TenkaStore {
  const TenkaStore({
    required this.baseUrl,
    required this.modules,
  });

  factory TenkaStore.fromJson(final JsonMap json) => TenkaStore(
        baseUrl: json['baseUrl'] as String,
        modules: castJsonMap<String, JsonMap>(json['modules']).map(
          (final String k, final JsonMap v) => MapEntry<String, TenkaMetadata>(
            k,
            TenkaMetadata.fromJson(v),
          ),
        ),
      );

  final String baseUrl;
  final Map<String, TenkaMetadata> modules;

  JsonMap toJson() => <dynamic, dynamic>{
        'baseUrl': baseUrl,
        'modules': modules.map(
          (final String i, final TenkaMetadata x) =>
              MapEntry<String, JsonMap>(i, x.toJson()),
        ),
      };
}
