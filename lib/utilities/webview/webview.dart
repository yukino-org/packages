import 'dart:async';
import './models/provider.dart';

export './models/provider.dart';
export './models/webview.dart';

abstract class WebviewManager {
  static bool ready = false;

  static late final WebviewProvider<dynamic> provider;

  static Future<void> initialize<T extends WebviewProvider<T>>(
    final WebviewProvider<T> provider,
    final WebviewProviderOptions options,
  ) async {
    if (ready) throw Exception('Already in use');

    await provider.initialize(options);

    ready = true;
  }

  static Future<void> dispose() async {
    await provider.dispose();
  }
}
