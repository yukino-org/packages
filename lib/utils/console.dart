// ignore_for_file: avoid_print
import 'dart:async';
import 'package:colorize/colorize.dart';

export 'package:colorize/colorize.dart';

bool _isKindOfMap(final dynamic data) =>
    data is Map<dynamic, dynamic> || data is Iterable<dynamic>;

abstract class TenkaDevConsole {
  static final StreamController<String> _stream =
      StreamController<String>.broadcast();

  static late final Stream<String> stream = _stream.stream;

  static void ln() {
    _print(' ');
  }

  static void p(final String text) {
    _print(text);
  }

  static void err(final Object err, final StackTrace stackTrace) {
    _print(Colorize(err.toString()).red().toString().trim());
    _print(Colorize(stackTrace.toString()).darkGray().toString().trim());
  }

  static String qt(
    final dynamic data, {
    final String spacing = '',
    final String tabSpace = '    ',
    final bool isKey = false,
    final String? previous,
  }) {
    final List<String> lines = <String>[
      if (previous != null) previous,
    ];

    if (_isKindOfMap(data)) {
      final Map<dynamic, dynamic> entries;

      final bool isList = data is Iterable<dynamic>;
      final bool isMap = data is Map<dynamic, dynamic>;

      if (isMap) {
        entries = data;
      } else if (isList) {
        entries = data.toList().asMap();
      } else {
        throw Exception("Shouldn't be here");
      }

      for (final MapEntry<dynamic, dynamic> entry in entries.entries) {
        final bool isValueKindOfMap = _isKindOfMap(entry.value);

        final String prefix = Colorize(
          isList ? '- ' : '',
        ).darkGray().toString();

        final String key = qt(
          entry.key,
          isKey: true,
          tabSpace: tabSpace,
        );

        final String center =
            Colorize(':${isValueKindOfMap ? '\n' : ' '}').darkGray().toString();

        final String value = qt(
          entry.value,
          spacing: isValueKindOfMap ? spacing + tabSpace : '',
          tabSpace: tabSpace,
        );

        lines.add('$spacing$prefix$key$center$value');
      }
    } else {
      final Colorize colorizedData = Colorize(data.toString());

      if (data is num) {
        colorizedData.green();
      } else if (isKey && data is String) {
        colorizedData.cyan().toString();
      }

      lines.add('$spacing$colorizedData');
    }

    return lines.join('\n').replaceAllMapped(
          RegExp(
            r'https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)',
          ),
          (final Match match) =>
              Colorize(match.group(0)!).underline().toString(),
        );
  }

  static void _print(final String text) {
    _stream.add('$text\n');
    print(text);
  }
}
