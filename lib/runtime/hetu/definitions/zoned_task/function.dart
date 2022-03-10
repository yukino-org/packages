import 'dart:async';
import 'package:hetu_script/values.dart';

Future<dynamic> runAsZoned(
  final HTFunction function, {
  required final HTFunction onFail,
}) async {
  try {
    return await function.call();
  } catch (err) {
    return await onFail.call(positionalArgs: <dynamic>[err.toString()]);
  }
}
