import 'package:hetu_script/binding.dart';
import 'package:hetu_script/hetu_script.dart';
import 'class.dart';

class GlobalsClassBinding extends HTExternalClass {
  GlobalsClassBinding() : super('Globals');

  @override
  dynamic memberGet(
    final String varName, {
    final String? from,
  }) {
    switch (varName) {
      case 'Globals.isDebug':
        return Globals.isDebug;

      default:
        throw HTError.undefined(varName);
    }
  }
}
