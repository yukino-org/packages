import '../model.dart';

class TenkaCloudDS extends TenkaDataSource {
  TenkaCloudDS(this.url);

  final String url;

  @override
  TenkaDataSourceConverter<dynamic> get converter => TenkaCloudDSConverter();
}

class TenkaCloudDSConverter extends TenkaDataSourceConverter<TenkaCloudDS> {
  @override
  final String type = 'cloud';

  @override
  TenkaCloudDS fromTenkaDataSourceManifest(
    final TenkaDataSourceManifest manifest,
  ) {
    if (manifest.type != type) throw Exception('Invalid type');
    return TenkaCloudDS(manifest.data);
  }

  @override
  TenkaDataSourceManifest toTenkaDataSourceManifest(
    final TenkaCloudDS source,
  ) =>
      TenkaDataSourceManifest(type, source.url);

  static final TenkaCloudDSConverter converter = TenkaCloudDSConverter();
}
