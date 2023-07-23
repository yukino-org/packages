import 'dart:typed_data';
import 'package:beize_vm/beize_vm.dart';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:utilx/utils.dart';
import '../converter/exports.dart';

abstract class CryptoBindings {
  static void bind(final BeizeNamespace namespace) {
    final BeizeObjectValue value = BeizeObjectValue();
    value.setNamedProperty(
      'md5Convert',
      BeizeNativeFunctionValue.sync(
        (final BeizeNativeFunctionCall call) {
          final BeizeObjectValue input = call.argumentAt(0);
          return BeizeConvertNatives.newBytesList(
            md5.convert(BeizeConvertNatives.toBytes(input)).bytes,
          );
        },
      ),
    );
    value.setNamedProperty(
      'aesEncrypt',
      BeizeNativeFunctionValue.sync(
        (final BeizeNativeFunctionCall call) {
          final BeizeObjectValue options = call.argumentAt(0);
          final BeizeObjectValue input = options.getNamedProperty('input');
          final BeizeObjectValue key = options.getNamedProperty('key');
          final BeizeValue iv = options.getNamedProperty('iv');
          final BeizeStringValue mode = options.getNamedProperty('mode');
          final BeizeStringValue padding = options.getNamedProperty('padding');

          final Uint8List bKey =
              Uint8List.fromList(BeizeConvertNatives.toBytes(key));
          final List<int> bInput = BeizeConvertNatives.toBytes(input);
          final Uint8List? bIv = iv is! BeizeNullValue
              ? Uint8List.fromList(BeizeConvertNatives.toBytes(iv.cast()))
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
          return BeizeConvertNatives.newBytesList(output);
        },
      ),
    );
    value.setNamedProperty(
      'aesDecrypt',
      BeizeNativeFunctionValue.sync(
        (final BeizeNativeFunctionCall call) {
          final BeizeObjectValue options = call.argumentAt(0);
          final BeizeObjectValue input = options.getNamedProperty('input');
          final BeizeObjectValue key = options.getNamedProperty('key');
          final BeizeValue iv = options.getNamedProperty('iv');
          final BeizeStringValue mode = options.getNamedProperty('mode');
          final BeizeStringValue padding = options.getNamedProperty('padding');

          final Uint8List bKey =
              Uint8List.fromList(BeizeConvertNatives.toBytes(key));
          final Uint8List bInput =
              Uint8List.fromList(BeizeConvertNatives.toBytes(input));
          final Uint8List? bIv = iv is! BeizeNullValue
              ? Uint8List.fromList(BeizeConvertNatives.toBytes(iv.cast()))
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
          return BeizeConvertNatives.newBytesList(output);
        },
      ),
    );
    namespace.declare('Crypto', value);
  }
}
