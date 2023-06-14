import 'package:baize_vm/baize_vm.dart';
import 'bindings/crypto.dart';
import 'bindings/fuzzy.dart';
import 'bindings/html.dart';
import 'bindings/http.dart';
import 'bindings/languages.dart';
import 'bindings/tenvironment.dart';
import 'bindings/url.dart';

abstract class TenkaBaizeBindings {
  static void bind(final BaizeNamespace namespace) {
    CryptoBindings.bind(namespace);
    FuzzySearchBindings.bind(namespace);
    HtmlBindings.bind(namespace);
    HttpBindings.bind(namespace);
    LanguagesBindings.bind(namespace);
    TEnvironmentBindings.bind(namespace);
    UrlBindings.bind(namespace);
  }
}
