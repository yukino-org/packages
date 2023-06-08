import 'package:utilx/utils.dart';
import '../metadata/exports.dart';

class TenkaStore {
  const TenkaStore({
    required this.baseURLs,
    required this.modules,
    required this.builtAt,
    required this.checksum,
  });

  factory TenkaStore.fromJson(final JsonMap json) => TenkaStore(
        baseURLs: castJsonMap(json['baseURLs']),
        modules: castJsonMap<String, JsonMap>(json['modules']).map(
          (final String i, final JsonMap x) => MapEntry<String, TenkaMetadata>(
            i,
            TenkaMetadata.fromJson(x),
          ),
        ),
        builtAt: DateTime.parse(json['builtAt'] as String),
        checksum: json['checksum'] as String,
      );

  final Map<String, String> baseURLs;
  final Map<String, TenkaMetadata> modules;
  final DateTime builtAt;
  final String checksum;

  JsonMap toJson() => <dynamic, dynamic>{
        'baseURLs': baseURLs,
        'modules': modules.map(
          (final String i, final TenkaMetadata x) =>
              MapEntry<String, JsonMap>(i, x.toJson()),
        ),
        'builtAt': builtAt.toIso8601String(),
        'checksum': checksum,
      };

  static String generateChecksum() =>
      StringUtils.toHex(StringUtils.random(inputLength: 20));
}
