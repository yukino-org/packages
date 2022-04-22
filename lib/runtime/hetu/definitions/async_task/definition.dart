import '../../model.dart';
import 'binding.dart';

final HetuHelperClass hAsyncTaskClass = HetuHelperClass(
  definition: AsyncTaskClassBinding(),
  declaration: '''
external class AsyncTask {
  /// (() => DartFutureOr<T>, {
  ///   onDone: (T) => DartFutureOr<U>,
  ///   onFail: (Flaw) => DartFutureOr<U>,
  /// })<T = any, U = any> => DartFuture<U>;
  static fun resolve(function, { trace, onDone, onFail });
  
  /// ((() => DartFutureOr<T>)[], {
  ///   onDone: (T[]) => DartFutureOr<U>,
  ///   onFail: (Flaw) => DartFutureOr<U>,
  /// })<T = any, U = any> => DartFuture<U>;
  static fun resolveAll(functions, { trace, onDone, onFail });
  
  /// (Duration, () => DartFutureOr<T>)<T = any> => DartFuture<T>;
  static fun wait(duration, callback);
  
  /// (T)<T = any> => DartFuture<T>;
  static fun value(data);
}
      '''
      .trim(),
);
