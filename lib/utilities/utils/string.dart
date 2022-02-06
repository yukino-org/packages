import 'dart:math';

abstract class StringUtils {
  static String capitalize(final String string) => string.isNotEmpty
      ? '${string.substring(0, 1).toUpperCase()}${string.substring(1).toLowerCase()}'
      : string;

  static String random({
    final int inputLength = 6,
    final String characters =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890-=',
  }) {
    final Random r = Random();

    return List<String>.generate(
      inputLength,
      (final int i) => characters[r.nextInt(characters.length)],
    ).join();
  }

  static String toHex(final String input) =>
      input.codeUnits.map((final int x) => x.toRadixString(16)).join();

  static String render(
    final String template,
    final Map<String, String> context,
  ) =>
      template.replaceAllMapped(RegExp('{{{(.*?)}}}'), (final Match match) {
        final String key = match.group(1)!.trim();
        return context.containsKey(key) ? context[key]! : 'null';
      });

  static String pascalToSnakeCase(final String pascal) =>
      pascal.replaceAllMapped(
        RegExp('[A-Z]'),
        (final Match match) => '_${match.group(0)!.toLowerCase()}',
      );

  static String pascalPretty(final String pascal) => pascal.replaceAllMapped(
        RegExp('[A-Z]'),
        (final Match match) => ' ${match.group(0)!}',
      );
}
