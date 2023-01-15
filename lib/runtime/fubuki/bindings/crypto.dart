import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:fubuki_vm/fubuki_vm.dart';
import 'package:utilx/utils.dart';

abstract class CryptoBindings {
  static void bind(final FubukiNamespace namespace) {
    final FubukiObjectValue value = FubukiObjectValue();
    value.set(
      FubukiStringValue('md5Convert'),
      FubukiNativeFunctionValue.sync(
        (final FubukiNativeFunctionCall call) {
          final FubukiObjectValue input = call.argumentAt(0);
          return FubukiConvertNatives.newBytesList(
            md5.convert(FubukiConvertNatives.toBytes(input)).bytes,
          );
        },
      ),
    );
    value.set(
      FubukiStringValue('aesEncrypt'),
      FubukiNativeFunctionValue.sync(
        (final FubukiNativeFunctionCall call) {
          final FubukiObjectValue options = call.argumentAt(0);
          final FubukiObjectValue input =
              options.get(FubukiStringValue('input')).cast();
          final FubukiObjectValue key =
              options.get(FubukiStringValue('key')).cast();
          final FubukiValue iv = options.get(FubukiStringValue('iv'));
          final FubukiStringValue mode =
              options.get(FubukiStringValue('mode')).cast();
          final FubukiStringValue padding =
              options.get(FubukiStringValue('padding')).cast();

          final Uint8List bKey =
              Uint8List.fromList(FubukiConvertNatives.toBytes(key));
          final List<int> bInput = FubukiConvertNatives.toBytes(input);
          final Uint8List? bIv = iv is! FubukiNullValue
              ? Uint8List.fromList(FubukiConvertNatives.toBytes(iv.cast()))
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
          return FubukiConvertNatives.newBytesList(output);
        },
      ),
    );
    value.set(
      FubukiStringValue('aesDecrypt'),
      FubukiNativeFunctionValue.sync(
        (final FubukiNativeFunctionCall call) {
          final FubukiObjectValue options = call.argumentAt(0);
          final FubukiObjectValue input =
              options.get(FubukiStringValue('input')).cast();
          final FubukiObjectValue key =
              options.get(FubukiStringValue('key')).cast();
          final FubukiValue iv = options.get(FubukiStringValue('iv'));
          final FubukiStringValue mode =
              options.get(FubukiStringValue('mode')).cast();
          final FubukiStringValue padding =
              options.get(FubukiStringValue('padding')).cast();

          final Uint8List bKey =
              Uint8List.fromList(FubukiConvertNatives.toBytes(key));
          final Uint8List bInput =
              Uint8List.fromList(FubukiConvertNatives.toBytes(input));
          final Uint8List? bIv = iv is! FubukiNullValue
              ? Uint8List.fromList(FubukiConvertNatives.toBytes(iv.cast()))
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
          return FubukiConvertNatives.newBytesList(output);
        },
      ),
    );
    namespace.declare('Crypto', value);
  }
}