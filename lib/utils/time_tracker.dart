class TimeTracker {
  late final int _start;

  void start() {
    _start = DateTime.now().millisecondsSinceEpoch;
  }

  int get elapsed => DateTime.now().millisecondsSinceEpoch - _start;
}
