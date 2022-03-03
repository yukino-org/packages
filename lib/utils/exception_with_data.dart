class ExceptionWithData implements Exception {
  const ExceptionWithData(this.error, this.data);

  final String error;
  final dynamic data;

  @override
  String toString() => 'ExceptionWithData: $error\nData:\n$data';
}
