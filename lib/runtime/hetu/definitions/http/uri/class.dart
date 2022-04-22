extension UriUtils on Uri {
  static String tryEncodeURL(final String url) {
    try {
      if (url != Uri.decodeFull(url)) return url;
    } catch (_) {}

    return Uri.encodeFull(url);
  }

  static const String defaultEnsureScheme = 'https';
  static String ensureScheme(
    final String url, {
    final String scheme = defaultEnsureScheme,
  }) =>
      !url.startsWith(scheme) ? '$scheme:$url' : url;

  static String ensureURL(final String url) => tryEncodeURL(ensureScheme(url));
}
