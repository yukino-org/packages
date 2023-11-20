import 'package:utilx/utilx.dart';
import '../metadata/exports.dart';

class TenkaStore {
  const TenkaStore({
    required this.baseUrl,
    required this.modules,
  });

  factory TenkaStore.fromJson(final JsonMap json) => TenkaStore(
        baseUrl: json['baseUrl'] as String,
        modules: Map<String, TenkaMetadata>.fromEntries(
          castList<JsonMap>(json['modules']).map(
            (final JsonMap x) {
              final TenkaMetadata metadata = TenkaMetadata.fromJson(x);
              return MapEntry<String, TenkaMetadata>(metadata.id, metadata);
            },
          ),
        ),
      );

  final String baseUrl;
  final Map<String, TenkaMetadata> modules;

  JsonMap toJson() => <dynamic, dynamic>{
        'baseUrl': baseUrl,
        'modules':
            modules.values.map((final TenkaMetadata x) => x.toJson()).toList(),
      };
}
