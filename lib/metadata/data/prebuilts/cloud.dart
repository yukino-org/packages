import '../model.dart';

class TenkaCloudDS extends EDataSource {
  TenkaCloudDS(this.url);

  factory TenkaCloudDS.fromEDataSourceJson(final TenkaDataSourceJson parsed) {
    if (parsed.type != type) throw Exception('Invalid type');
    return TenkaCloudDS(parsed.data);
  }

  final String url;

  @override
  TenkaDataSourceJson toTenkaDataSourceJson() => TenkaDataSourceJson(type, url);

  static const String type = 'cloud';
}
