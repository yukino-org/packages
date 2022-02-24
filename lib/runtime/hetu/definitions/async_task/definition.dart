import '../../model.dart';
import 'binding.dart';

final HetuHelperClass hAsyncTaskClass = HetuHelperClass(
  definition: AsyncTaskClassBinding(),
  declaration: '''
external class AsyncTask {
  /// (() => DartFutureOr<T>, {
  ///   trace: TaskTrace,
  ///   onDone: (T) => DartFutureOr<U>,
  ///   onFail: (Flaw) => DartFutureOr<U>,
  /// })<T = any, U = any> => DartFuture<U>;
  static fun resolve(function, { trace, onDone, onFail });
  
  /// ((() => DartFutureOr<T>)[], {
  ///   trace: TaskTrace,
  ///   onDone: (T[]) => DartFutureOr<U>,
  ///   onFail: (Flaw) => DartFutureOr<U>,
  /// })<T = any, U = any> => DartFuture<U>;
  static fun resolveAll(functions, { trace, onDone, onFail });
  
  /// (int, () => DartFutureOr<T>)<T = any> => DartFuture<T>;
  static fun wait(ms, callback);
}
      '''
      .trim(),
);
