class URL {
  const URL._(this.uri);

  factory URL.parse(final String url) => URL._(Uri.parse(url));

  final Uri uri;

  bool isScheme(final String scheme) => uri.isScheme(scheme);
  URL normalizePath() => URL._(uri.normalizePath());
  URL removeFragment() => URL._(uri.removeFragment());

  @override
  String toString() => uri.toString();

  bool get hasAbsolutePath => uri.hasAbsolutePath;
  bool get hasAuthority => uri.hasAuthority;
  bool get hasEmptyPath => uri.hasEmptyPath;
  bool get hasFragment => uri.hasFragment;
  bool get hasPort => uri.hasPort;
  bool get hasQuery => uri.hasQuery;
  bool get hasScheme => uri.hasScheme;
  bool get isAbsolute => uri.isAbsolute;

  String get authority => uri.authority;
  String get host => uri.host;
  String get origin => uri.origin;
  int get port => uri.port;
  String get path => uri.path;
  List<String> get pathSegments => uri.pathSegments;
  String get fragment => uri.fragment;
  String get query => uri.query;
  Map<String, String> get queryParameters => uri.queryParameters;
  Map<String, List<String>> get queryParametersAll => uri.queryParametersAll;
  String get scheme => uri.scheme;

  static const String defaultEnsureScheme = 'https';

  static String ensureScheme(
    final String url, {
    final String scheme = defaultEnsureScheme,
  }) =>
      !url.startsWith(scheme) ? '$scheme:$url' : url;

  static String tryEncodeURL(final String url) {
    try {
      if (url != Uri.decodeFull(url)) return url;
    } catch (_) {}

    return Uri.encodeFull(url);
  }

  static String ensureURL(final String url) => tryEncodeURL(ensureScheme(url));

  static String decodeComponent(final String query) =>
      Uri.decodeComponent(query);

  static String decodeQueryComponent(final String query) =>
      Uri.decodeQueryComponent(query);

  static String encodeComponent(final String query) =>
      Uri.encodeComponent(query);

  static String encodeFull(final String query) => Uri.encodeFull(query);

  static Map<String, String> splitQueryString(final String query) =>
      Uri.splitQueryString(query);

  static String joinQueryParameters(final Map<String, String> query) =>
      Uri(queryParameters: query).query;
}
