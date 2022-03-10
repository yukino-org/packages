import '../../model.dart';
import 'function.dart';

final HetuHelperFunction hZonedTaskFunction = HetuHelperFunction(
  name: 'runAsZoned',
  definition: runAsZoned,
  declaration: '''
/// (() => DartFutureOr<T>, {
///   onFail: (Flaw) => DartFutureOr<U>,
/// })<T = any, U = any> => DartFuture<U>;
external fun runAsZoned(function, { onFail });
      '''
      .trim(),
);
