import 'package:utilx/utilities/locale.dart';
import './search/info.dart';

typedef SearchFn = Future<List<SearchInfo>> Function(
  String terms,
  Locale locale,
);

class BaseExtractor {
  const BaseExtractor({
    required final this.defaultLocale,
    required final this.search,
  });

  final Locale defaultLocale;
  final SearchFn search;
}
