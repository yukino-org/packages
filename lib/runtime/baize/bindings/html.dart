import 'package:baize_vm/baize_vm.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as html;
import '../converter/exports.dart';

abstract class HtmlBindings {
  static void bind(final BaizeNamespace namespace) {
    final BaizeObjectValue value = BaizeObjectValue();
    value.setNamedProperty(
      'parse',
      BaizeNativeFunctionValue.sync(
        (final BaizeNativeFunctionCall call) {
          final BaizeStringValue value = call.argumentAt(0);
          return newHtmlElement(html.parse(value.value).documentElement!);
        },
      ),
    );
    namespace.declare('HtmlElement', value);
  }

  static BaizeValue newHtmlElement(final dom.Element element) {
    final BaizeObjectValue value = BaizeObjectValue();
    value.setNamedProperty(
      'classes',
      BaizeListValue(
        element.classes.map((final String x) => BaizeStringValue(x)).toList(),
      ),
    );
    value.setNamedProperty(
      'id',
      BaizeStringValue(element.id),
    );
    value.setNamedProperty(
      'text',
      BaizeStringValue(element.text),
    );
    value.setNamedProperty(
      'innerHtml',
      BaizeStringValue(element.innerHtml),
    );
    value.setNamedProperty(
      'outerHtml',
      BaizeStringValue(element.outerHtml),
    );
    final BaizeObjectValue attributes = BaizeObjectValue();
    element.attributes.forEach((final Object key, final String value) {
      attributes.set(
        BaizeStringValue(key.toString()),
        BaizeStringValue(value),
      );
    });
    value.setNamedProperty('attributes', attributes);
    value.setNamedProperty(
      'querySelector',
      BaizeNativeFunctionValue.sync(
        (final BaizeNativeFunctionCall call) {
          final BaizeStringValue selector = call.argumentAt(0);
          final dom.Element? selected = element.querySelector(selector.value);
          if (selected != null) return newHtmlElement(selected);
          return BaizeNullValue.value;
        },
      ),
    );
    value.setNamedProperty(
      'querySelectorAll',
      BaizeNativeFunctionValue.sync(
        (final BaizeNativeFunctionCall call) {
          final BaizeStringValue selector = call.argumentAt(0);
          final BaizeListValue selected = BaizeListValue();
          for (final dom.Element x
              in element.querySelectorAll(selector.value)) {
            selected.push(newHtmlElement(x));
          }
          return selected;
        },
      ),
    );
    return value;
  }
}
