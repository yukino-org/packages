import 'package:fubuki_vm/fubuki_vm.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as html;

abstract class HtmlBindings {
  static void bind(final FubukiNamespace namespace) {
    final FubukiObjectValue value = FubukiObjectValue();
    value.set(
      FubukiStringValue('parse'),
      FubukiNativeFunctionValue.asyncReturn(
        (final FubukiNativeFunctionCall call) async {
          final FubukiStringValue value = call.argumentAt(0);
          return newHtmlElement(html.parse(value).documentElement!);
        },
      ),
    );
    namespace.declare('HtmlElement', value);
  }

  static FubukiValue newHtmlElement(final dom.Element element) {
    final FubukiObjectValue value = FubukiObjectValue();
    value.set(
      FubukiStringValue('classes'),
      FubukiListValue(
        element.classes.map((final String x) => FubukiStringValue(x)).toList(),
      ),
    );
    value.set(
      FubukiStringValue('id'),
      FubukiStringValue(element.id),
    );
    value.set(
      FubukiStringValue('text'),
      FubukiStringValue(element.text),
    );
    value.set(
      FubukiStringValue('innerHtml'),
      FubukiStringValue(element.innerHtml),
    );
    value.set(
      FubukiStringValue('outerHtml'),
      FubukiStringValue(element.outerHtml),
    );
    final FubukiObjectValue attributes = FubukiObjectValue();
    element.attributes.forEach((final Object key, final String value) {
      attributes.set(
        FubukiStringValue(key.toString()),
        FubukiStringValue(value),
      );
    });
    value.set(FubukiStringValue('attributes'), attributes);
    value.set(
      FubukiStringValue('querySelector'),
      FubukiNativeFunctionValue.sync(
        (final FubukiNativeFunctionCall call) {
          final FubukiStringValue selector = call.argumentAt(0);
          final dom.Element? selected = element.querySelector(selector.value);
          if (selected != null) return newHtmlElement(selected);
          return FubukiNullValue.value;
        },
      ),
    );
    value.set(
      FubukiStringValue('querySelectorAll'),
      FubukiNativeFunctionValue.sync(
        (final FubukiNativeFunctionCall call) {
          final FubukiStringValue selector = call.argumentAt(0);
          final FubukiListValue selected = FubukiListValue();
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
