import '../../model.dart';
import 'binding.dart';

final HetuHelperClass hDurationClass = HetuHelperClass(
  definition: DurationClassBinding(),
  declaration: '''
external class Duration {
  // [regex] must be escaped since slashes are not preserved
  /// ({
  ///   days
  ///   hours
  ///   minutes
  ///   seconds
  ///   milliseconds
  ///   microseconds
  /// }) => Duration;
  construct({
    days,
    hours,
    minutes,
    seconds,
    milliseconds,
    microseconds,
  });

  /// int
  get inDays;
  /// int
  get inHours;
  /// int
  get inMinutes;
  /// int
  get inSeconds;
  /// int
  get inMilliseconds;
  /// int
  get inMicroseconds;
  
  /// () => string
  fun toString();
}
      '''
      .trim(),
);
