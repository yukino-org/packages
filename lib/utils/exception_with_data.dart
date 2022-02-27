class ExceptionWithData implements Exception {
  const ExceptionWithData(this.error, this.data);

  final String error;
  final dynamic data;
}
