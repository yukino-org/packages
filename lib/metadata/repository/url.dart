typedef TenkaStoreCDNConstructor = String Function(String ref);

class TenkaStoreURLResolver {
  const TenkaStoreURLResolver({
    this.deployMode,
    this.constructBaseURL = constructGithubRawBaseURL,
  });

  final String? deployMode;
  final TenkaStoreCDNConstructor constructBaseURL;

  String resolveURL(final String route, [final String? baseURL]) =>
      '${baseURL ?? this.baseURL}/$route';

  String get ref => deployMode != null ? 'dist-$deployMode' : 'dist';
  String get baseURL => constructBaseURL(ref);

  String get storeURL => '$baseURL/store.json';
  String get checksumURL => '$baseURL/.checksum';
  String get manifestURL => '$baseURL/manifest.json';

  static const String githubUsername = 'yukino-org';
  static const String githubRepo = 'tenka-store';

  static String constructGithubRawBaseURL(final String ref) =>
      'https://raw.githubusercontent.com/$githubUsername/$githubRepo/$ref';

  static String constructJsDelivrBaseURL(final String ref) =>
      'https://cdn.jsdelivr.net/gh/$githubUsername/$githubRepo@$ref';
}
