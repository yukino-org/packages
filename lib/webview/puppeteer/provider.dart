import 'dart:io';
import 'package:puppeteer/plugins/stealth.dart';
import 'package:puppeteer/puppeteer.dart';
import 'package:utilx/utils.dart';
import 'package:utilx/webview/webview.dart';
import 'webview.dart';

class PuppeteerProvider extends WebviewProvider<PuppeteerProvider> {
  Browser? browser;
  BrowserContext? context;
  String? chromePath;
  late bool headless;

  @override
  Future<void> initialize(final WebviewProviderOptions options) async {
    headless = !options.devMode;

    for (final Future<bool> Function() x in <Future<bool> Function()>[
      () async {
        await _launch(_getBrowserPath());
        return true;
      },
      () async {
        final RevisionInfo revision =
            await downloadChrome(cachePath: options.localChromiumPath);
        await _launch(revision.executablePath);
        return true;
      },
    ]) {
      if ((await FunctionUtils.tryCatchAsync<bool>(x)).last == true) {
        break;
      }
    }

    await super.initialize(options);
  }

  Future<void> _launch(final String executablePath) async {
    puppeteer.plugins.add(StealthPlugin());

    browser = await puppeteer.launch(
      executablePath: executablePath,
      args: headless
          ? <String>[
              '--single-process',
              '--no-zygote',
              '--no-sandbox',
            ]
          : null,
      headless: headless,
    );

    context = await browser!.createIncognitoBrowserContext();

    chromePath = executablePath;
  }

  @override
  Future<PuppeteerWebview> create() async {
    final PuppeteerWebview webview = PuppeteerWebview(provider: this);
    await webview.initialize();
    return webview;
  }

  Future<void> _disposePages(final List<Page> pages) => Future.wait(
        pages.map((final Page x) => x.close()),
      );

  @override
  Future<void> dispose() async {
    if (browser != null) {
      await _disposePages(await context!.pages);
      context!.close();
      context = null;

      await _disposePages(await browser!.pages);
      await browser!.close();
      browser = null;
    }

    await super.dispose();
  }

  static bool isSupported() =>
      Platform.isWindows || Platform.isLinux || Platform.isMacOS;

  static String _getBrowserPath() {
    for (final String? Function() x in <String? Function()>[
      () => BrowserPath.chrome,
      () => BrowserPath.chromeBeta,
      () => BrowserPath.chromeCanary,
      () => BrowserPath.chromeDev,
    ]) {
      final String? path = FunctionUtils.tryCatch<String?>(x).last;
      if (path != null) {
        return path;
      }
    }

    throw Exception('Chrome is not installed');
  }
}
