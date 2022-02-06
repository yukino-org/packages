import 'dart:async';
import './models/provider.dart';

export './models/provider.dart';
export './models/webview.dart';

class WebviewManagerInitializeOptions {
  const WebviewManagerInitializeOptions(this.provider, this.options);

  final WebviewProvider<dynamic> provider;
  final WebviewProviderOptions options;
}

abstract class WebviewManager {
  static bool ready = false;

  static late final WebviewProvider<dynamic> provider;

  static Future<void> initialize(
    final WebviewManagerInitializeOptions options,
  ) async {
    if (ready) throw Exception('Already in use');

    provider = options.provider;
    await provider.initialize(options.options);

    ready = true;
  }

  static Future<void> dispose() async {
    await provider.dispose();
  }
}
