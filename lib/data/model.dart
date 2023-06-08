import 'package:utilx/utils.dart';

import 'prebuilts/base64.dart';
import 'prebuilts/cloud.dart';
import 'prebuilts/local_file.dart';

class TenkaDataSourceManifest {
  const TenkaDataSourceManifest(this.type, this.data);

  factory TenkaDataSourceManifest.fromJson(final JsonMap json) =>
      TenkaDataSourceManifest(json['type'] as String, json['data'] as String);

  final String type;
  final String data;

  JsonMap toJson() => <dynamic, dynamic>{
        'type': type,
        'data': data,
      };
}

abstract class TenkaDataSource {
  TenkaDataSourceConverter<dynamic> get converter;

  JsonMap toJson() => converter.toTenkaDataSourceManifest(this).toJson();

  static T fromTenkaDataSourceManifest<T extends TenkaDataSource>(
    final TenkaDataSourceManifest manifest,
  ) =>
      TenkaDataSourceConverter.getConverter<T>(manifest)
          .fromTenkaDataSourceManifest(manifest);

  static T fromJson<T extends TenkaDataSource>(
    final JsonMap json,
  ) =>
      fromTenkaDataSourceManifest(TenkaDataSourceManifest.fromJson(json));
}

abstract class TenkaDataSourceConverter<T extends TenkaDataSource> {
  T fromTenkaDataSourceManifest(final TenkaDataSourceManifest manifest);
  TenkaDataSourceManifest toTenkaDataSourceManifest(final T source);

  String get type;

  static final List<TenkaDataSourceConverter<dynamic>> converters =
      <TenkaDataSourceConverter<dynamic>>[
    TenkaBase64DSConverter.converter,
    TenkaCloudDSConverter.converter,
    TenkaLocalFileDSConverter.converter,
  ];

  static TenkaDataSourceConverter<T> getConverter<T extends TenkaDataSource>(
    final TenkaDataSourceManifest manifest,
  ) =>
      TenkaDataSourceConverter.converters.firstWhere(
        (final TenkaDataSourceConverter<dynamic> x) => x.type == manifest.type,
      ) as TenkaDataSourceConverter<T>;
}
