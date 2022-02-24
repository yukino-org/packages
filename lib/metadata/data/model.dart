import 'prebuilts/base64.dart';
import 'prebuilts/cloud.dart';
import 'prebuilts/local_file.dart';

class TenkaDataSourceJson {
  const TenkaDataSourceJson(this.type, this.data);

  factory TenkaDataSourceJson.fromJson(final Map<dynamic, dynamic> json) =>
      TenkaDataSourceJson(json['type'] as String, json['data'] as String);

  final String type;
  final String data;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'type': type,
        'data': data,
      };
}

abstract class TenkaDataSource {
  TenkaDataSourceJson toTenkaDataSourceJson();

  Map<dynamic, dynamic> toJson() => toTenkaDataSourceJson().toJson();

  static TenkaDataSource fromJson(final Map<dynamic, dynamic> json) =>
      fromTenkaDataSourceJson(TenkaDataSourceJson.fromJson(json));

  static TenkaDataSource fromTenkaDataSourceJson(final TenkaDataSourceJson parsed) {
    switch (parsed.type) {
      case TenkaBase64DS.type:
        return TenkaBase64DS.fromTenkaDataSourceJson(parsed);

      case ECloudDS.type:
        return TenkaCloudDS.fromTenkaDataSourceJson(parsed);

      case ELocalFileDS.type:
        return TenkaLocalFileDS.fromTenkaDataSourceJson(parsed);

      default:
        throw Exception('Unsupported type');
    }
  }
}
