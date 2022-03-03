import 'package:utilx/utilities/utils.dart';
import '../metadata/exports.dart';

class TenkaStore {
  const TenkaStore({
    required this.baseURLs,
    required this.modules,
    required this.builtAt,
    required this.checksum,
  });

  factory TenkaStore.fromJson(final Map<dynamic, dynamic> json) => TenkaStore(
        baseURLs:
            (json['baseURLs'] as Map<dynamic, dynamic>).cast<String, String>(),
        modules: (json['modules'] as Map<dynamic, dynamic>)
            .cast<String, Map<dynamic, dynamic>>()
            .map(
              (final String i, final Map<dynamic, dynamic> x) =>
                  MapEntry<String, TenkaMetadata>(
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

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'baseURLs': baseURLs,
        'modules': modules.map(
          (final String i, final TenkaMetadata x) =>
              MapEntry<String, Map<dynamic, dynamic>>(i, x.toJson()),
        ),
        'builtAt': builtAt.toIso8601String(),
        'checksum': checksum,
      };

  static String generateChecksum() =>
      StringUtils.toHex(StringUtils.random(inputLength: 20));
}
