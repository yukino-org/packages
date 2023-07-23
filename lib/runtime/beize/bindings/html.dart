import 'package:beize_vm/beize_vm.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as html;
import '../converter/exports.dart';

abstract class HtmlBindings {
  static void bind(final BeizeNamespace namespace) {
    final BeizeObjectValue value = BeizeObjectValue();
    value.setNamedProperty(
      'parse',
      BeizeNativeFunctionValue.sync(
        (final BeizeNativeFunctionCall call) {
          final BeizeStringValue value = call.argumentAt(0);
          return newHtmlElement(html.parse(value.value).documentElement!);
        },
      ),
    );
    namespace.declare('HtmlElement', value);
  }

  static BeizeValue newHtmlElement(final dom.Element element) {
    final BeizeObjectValue value = BeizeObjectValue();
    value.setNamedProperty(
      'classes',
      BeizeListValue(
        element.classes.map((final String x) => BeizeStringValue(x)).toList(),
      ),
    );
    value.setNamedProperty(
      'id',
      BeizeStringValue(element.id),
    );
    value.setNamedProperty(
      'text',
      BeizeStringValue(element.text),
    );
    value.setNamedProperty(
      'innerHtml',
      BeizeStringValue(element.innerHtml),
    );
    value.setNamedProperty(
      'outerHtml',
      BeizeStringValue(element.outerHtml),
    );
    final BeizeObjectValue attributes = BeizeObjectValue();
    element.attributes.forEach((final Object key, final String value) {
      attributes.set(
        BeizeStringValue(key.toString()),
        BeizeStringValue(value),
      );
    });
    value.setNamedProperty('attributes', attributes);
    value.setNamedProperty(
      'querySelector',
      BeizeNativeFunctionValue.sync(
        (final BeizeNativeFunctionCall call) {
          final BeizeStringValue selector = call.argumentAt(0);
          final dom.Element? selected = element.querySelector(selector.value);
          if (selected != null) return newHtmlElement(selected);
          return BeizeNullValue.value;
        },
      ),
    );
    value.setNamedProperty(
      'querySelectorAll',
      BeizeNativeFunctionValue.sync(
        (final BeizeNativeFunctionCall call) {
          final BeizeStringValue selector = call.argumentAt(0);
          final BeizeListValue selected = BeizeListValue();
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
