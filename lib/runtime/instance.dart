import 'package:hetu_script/hetu_script.dart';

const String _extractorIdentifier = 'extractor';

class ERuntimeInstance {
  final Hetu hetu = Hetu();

  Future<T> getExtractor<T>() async {
    final dynamic result = await hetu.eval(_extractorIdentifier);
    return result as T;
  }
}
