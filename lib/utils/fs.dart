import 'dart:io';

abstract class FSUtils {
  static final RegExp invalidPathReplacer = RegExp(r'[^\\\/\.\w- ]+');

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

  static Future<void> recreateDirectory(final Directory directory) async {
    if (await directory.exists()) {
      await directory.delete(recursive: true);
    }

    await directory.create(recursive: true);
  }

  static Future<void> recreateFile(final File file) async {
    if (await file.exists()) {
      await file.delete(recursive: true);
    }

    await file.create(recursive: true);
  }

  static String ensureWindowsPath(
    final String path, [
    final String replace = ' ',
  ]) {
    final String prefix =
        RegExp('^[A-z]:').hasMatch(path) ? path.substring(0, 2) : '';

    return prefix +
        path.substring(prefix.length).replaceAll(invalidPathReplacer, replace);
  }

  static String ensureUnixPath(
    final String path, [
    final String replace = ' ',
  ]) =>
      path.replaceAll(invalidPathReplacer, replace);

  static String ensurePath(
    final String path, [
    final String replace = ' ',
  ]) {
    if (Platform.isWindows) {
      return ensureWindowsPath(path, replace);
    }
    return ensureUnixPath(path, replace);
  }

  static bool isValidPath(final String path) => path == ensurePath(path);
}
