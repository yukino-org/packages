import 'dart:io';

abstract class FSUtils {
  static Future<void> ensureDirectory(final Directory directory) async {
    if (!(await directory.exists())) {
      await directory.create(recursive: true);
    }
  }

  static Future<void> ensureFile(final File file) async {
    if (!(await file.exists())) {
      await file.create(recursive: true);
    }
  }
}
