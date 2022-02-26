import 'package:hetu_script/hetu_script.dart';

class TenkaRuntimeError {
  const TenkaRuntimeError({
    required final this.error,
    final this.line,
  });

  final HTError error;
  final int? line;

  @override
  String toString() => error.toString().replaceFirst(
        'Line: ${error.line}',
        'Thrown Line: ${error.line}, Purged Line: ${line ?? '-'}',
      );
}
