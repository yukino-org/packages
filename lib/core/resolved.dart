import 'dart:convert';

import 'package:extensions_runtime/extensions_runtime.dart';
import 'package:utilx/utilities/locale.dart';
import './base.dart';
import './version.dart';

class ResolvedExtension extends BaseExtension {
  const ResolvedExtension({
    required final String name,
    required final String id,
    required final String author,
    required final ExtensionVersion version,
    required final ExtensionType type,
    required final String image,
    required final bool nsfw,
    required final Locale defaultLocale,
    required final this.code,
  }) : super(
          name: name,
          id: id,
          author: author,
          version: version,
          type: type,
          image: image,
          nsfw: nsfw,
          defaultLocale: defaultLocale,
        );

  factory ResolvedExtension.fromJson(final Map<dynamic, dynamic> json) {
    final BaseExtension base = BaseExtension.fromJson(json);

    return ResolvedExtension(
      name: base.name,
      id: base.id,
      author: base.author,
      version: base.version,
      type: base.type,
      image: base.image,
      code: json['code'] as String,
      nsfw: base.nsfw,
      defaultLocale: base.defaultLocale,
    );
  }

  final String code;

  Future<ERuntimeInstance> getRuntime() async {
    final ERuntimeInstance instance = await ERuntimeManager.create();
    await instance.loadByteCode(base64.decode(code));
    return instance;
  }

  @override
  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        ...super.toJson(),
        'code': code,
      };
}
