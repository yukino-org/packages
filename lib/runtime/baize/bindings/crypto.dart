import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:baize_vm/baize_vm.dart';
import 'package:utilx/utils.dart';
import '../converter/exports.dart';

abstract class CryptoBindings {
  static void bind(final BaizeNamespace namespace) {
    final BaizeObjectValue value = BaizeObjectValue();
    value.setNamedProperty(
      'md5Convert',
      BaizeNativeFunctionValue.sync(
        (final BaizeNativeFunctionCall call) {
          final BaizeObjectValue input = call.argumentAt(0);
          return BaizeConvertNatives.newBytesList(
            md5.convert(BaizeConvertNatives.toBytes(input)).bytes,
          );
        },
      ),
    );
    value.setNamedProperty(
      'aesEncrypt',
      BaizeNativeFunctionValue.sync(
        (final BaizeNativeFunctionCall call) {
          final BaizeObjectValue options = call.argumentAt(0);
          final BaizeObjectValue input = options.getNamedProperty('input');
          final BaizeObjectValue key = options.getNamedProperty('key');
          final BaizeValue iv = options.getNamedProperty('iv');
          final BaizeStringValue mode = options.getNamedProperty('mode');
          final BaizeStringValue padding = options.getNamedProperty('padding');

          final Uint8List bKey =
              Uint8List.fromList(BaizeConvertNatives.toBytes(key));
          final List<int> bInput = BaizeConvertNatives.toBytes(input);
          final Uint8List? bIv = iv is! BaizeNullValue
              ? Uint8List.fromList(BaizeConvertNatives.toBytes(iv.cast()))
              : null;
          final Encrypter encrypter = Encrypter(
            AES(
              Key(bKey),
              mode: EnumUtils.find(AESMode.values, mode.value),
              padding: padding.value,
            ),
          );
          final List<int> output = encrypter
              .encryptBytes(bInput, iv: bIv != null ? IV(bIv) : null)
              .bytes;
          return BaizeConvertNatives.newBytesList(output);
        },
      ),
    );
    value.setNamedProperty(
      'aesDecrypt',
      BaizeNativeFunctionValue.sync(
        (final BaizeNativeFunctionCall call) {
          final BaizeObjectValue options = call.argumentAt(0);
          final BaizeObjectValue input = options.getNamedProperty('input');
          final BaizeObjectValue key = options.getNamedProperty('key');
          final BaizeValue iv = options.getNamedProperty('iv');
          final BaizeStringValue mode = options.getNamedProperty('mode');
          final BaizeStringValue padding = options.getNamedProperty('padding');

          final Uint8List bKey =
              Uint8List.fromList(BaizeConvertNatives.toBytes(key));
          final Uint8List bInput =
              Uint8List.fromList(BaizeConvertNatives.toBytes(input));
          final Uint8List? bIv = iv is! BaizeNullValue
              ? Uint8List.fromList(BaizeConvertNatives.toBytes(iv.cast()))
              : null;
          final Encrypter encrypter = Encrypter(
            AES(
              Key(bKey),
              mode: EnumUtils.find(AESMode.values, mode.value),
              padding: padding.value,
            ),
          );
          final List<int> output = encrypter.decryptBytes(
            Encrypted(bInput),
            iv: bIv != null ? IV(bIv) : null,
          );
          return BaizeConvertNatives.newBytesList(output);
        },
      ),
    );
    namespace.declare('Crypto', value);
  }
}
