class TenkaManifestData {
  const TenkaManifestData({
    required this.lastRef,
  });

  factory TenkaManifestData.fromJson(final Map<dynamic, dynamic> json) =>
      TenkaManifestData(lastRef: json['lastRef'] as String);

  final String lastRef;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'lastRef': lastRef,
      };
}

class TenkaManifest {
  const TenkaManifest(this.data);

  factory TenkaManifest.fromJson(final Map<dynamic, dynamic> json) => TenkaManifest(
        json.cast<String, Map<dynamic, dynamic>>().map(
              (final String key, final Map<dynamic, dynamic> value) =>
                  MapEntry<String, EManifestData>(
                key,
                TenkaManifestData.fromJson(value),
              ),
            ),
      );

  final Map<String, TenkaManifestData> data;

  Map<dynamic, dynamic> toJson() => data.map(
        (final String key, final TenkaManifestData value) =>
            MapEntry<String, Map<dynamic, dynamic>>(
          key,
          value.toJson(),
        ),
      );
}
