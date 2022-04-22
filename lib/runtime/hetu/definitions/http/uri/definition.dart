import '../../../model.dart';
import 'binding.dart';

final HetuHelperClass hUriClass = HetuHelperClass(
  definition: UriClassBinding(),
  declaration: '''
external class Uri {
  /// bool
  get hasAbsolutePath;

  /// bool
  get hasAuthority;

  /// bool
  get hasEmptyPath;

  /// bool
  get hasFragment;

  /// bool
  get hasPort;

  /// bool
  get hasQuery;

  /// bool
  get hasScheme;

  /// bool
  get isAbsolute;

  /// string
  get authority;

  /// string
  get host;

  /// string
  get origin;

  /// int
  get port;

  /// string
  get path;

  /// string[]
  get pathSegments;

  /// string
  get fragment;

  /// string
  get query;

  /// Map<string, string>
  get queryParameters;

  /// Map<string, string[]>
  get queryParametersAll;

  /// string
  get scheme;

  /// (string) => bool;
  fun isScheme(scheme);

  /// () => Uri;
  fun normalizePath(uri);

  /// () => Uri;
  fun removeFragment();

  /// () => string;
  fun toString();

  /// (string) => Uri;
  static fun parse(url);

  /// (string, {
  ///   scheme: string,
  /// }) => string;
  static fun ensureScheme(url, { scheme });

  /// (string) => string;
  static fun tryEncodeURL(url);

  /// (string) => string;
  static fun ensureURL(url);

  /// (string) => string;
  static fun decodeComponent(query);

  /// (string) => string;
  static fun decodeQueryComponent(query);

  /// (string) => string;
  static fun encodeComponent(query);

  /// (string) => string;
  static fun encodeFull(url);

  /// (string) => Map<string, string>;
  static fun splitQueryString(query);

  /// (Map<string, string>) => string;
  static fun joinQueryString(query);
}
      '''
      .trim(),
);
