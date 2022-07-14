class TwinTuple<A, B> {
  const TwinTuple(this.first, this.last);

  final A first;
  final B last;
}

class TripleTuple<A, B> {
  const TripleTuple(this.first, this.middle, this.last);

  final A first;
  final A middle;
  final B last;
}
