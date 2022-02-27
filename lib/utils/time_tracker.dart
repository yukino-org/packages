class TimeTracker {
  late final DateTime startedAt;
  late final DateTime endedAt;

  void start() {
    startedAt = DateTime.now();
  }

  void end() {
    endedAt = DateTime.now();
  }

  int get elapsed =>
      endedAt.millisecondsSinceEpoch - startedAt.millisecondsSinceEpoch;
}
