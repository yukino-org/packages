class Flaw implements Exception {
  const Flaw(this.exception);

  factory Flaw.fromUnknown(final dynamic err) => Flaw(Exception(err));

  final Exception exception;

  @override
  String toString() => exception.toString();

  static void throwFlaw(final dynamic err) {
    if (err is Flaw) {
      throw err;
    }

    throw Flaw.fromUnknown(err);
  }
}
