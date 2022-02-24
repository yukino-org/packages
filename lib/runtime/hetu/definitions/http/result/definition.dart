import '../../../model.dart';
import 'binding.dart';

final HetuHelperClass hHttpResponseClass = HetuHelperClass(
  definition: HttpResponseClassBinding(),
  declaration: '''
external class HttpResponse {
  /// string
  final body;
  
  /// Map<string, string>
  final headers;
  
  /// int
  final statusCode;
}
      '''
      .trim(),
);
