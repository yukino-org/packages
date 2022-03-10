import 'dart:async';
import 'package:hetu_script/values.dart';

Future<dynamic> runAsZoned(
  final HTFunction function, {
  required final HTFunction onFail,
}) async {
  try {
    return function.call();
  } catch (err) {
    return onFail.call(positionalArgs: <dynamic>[err.toString()]);
  }
}
