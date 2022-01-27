import './console.dart';

class TTimer {
  late final int started;

  void start() {
    started = DateTime.now().millisecondsSinceEpoch;
  }

  void pass() {
    TConsole.print(
      '${Colorize('✓').green()} Passed in ${Colorize('${elapsed}ms').green()}',
    );
  }

  void fail() {
    TConsole.print(
      '${Colorize('✕').red()} Failed in ${Colorize('${elapsed}ms').red()}',
    );
  }

  int get elapsed => DateTime.now().millisecondsSinceEpoch - started;
}
