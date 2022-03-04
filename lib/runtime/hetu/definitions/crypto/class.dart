import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import '../converter/bytes/class.dart';

enum AESPadding {
  none,
  pkcs7,
}

extension AESPaddingUtils on AESPadding {
  String? get encryptPadding {
    switch (this) {
      case AESPadding.none:
        return null;

      case AESPadding.pkcs7:
        return 'PKCS7';
    }
  }
}

class Crypto {
  static const AESMode defaultAESMode = AESMode.sic;
  static const AESPadding defaultAESPadding = AESPadding.pkcs7;

  static BytesContainer md5Convert(final BytesContainer data) =>
      BytesContainer.fromList(md5.convert(data.list).bytes);

  static BytesContainer aesEncrypt({
    required final BytesContainer input,
    required final BytesContainer key,
    final BytesContainer? iv,
    final AESMode mode = defaultAESMode,
    final AESPadding padding = defaultAESPadding,
  }) =>
      BytesContainer.fromList(
        Encrypter(
          AES(
            Key(key.bytes),
            mode: mode,
            padding: padding.encryptPadding,
          ),
        )
            .encryptBytes(
              input.bytes,
              iv: iv != null ? IV(iv.bytes) : null,
            )
            .bytes,
      );

  static BytesContainer aesDecrypt({
    required final BytesContainer encrypted,
    required final BytesContainer key,
    final BytesContainer? iv,
    final AESMode mode = defaultAESMode,
    final AESPadding padding = defaultAESPadding,
  }) =>
      BytesContainer.fromList(
        Encrypter(
          AES(
            Key(key.bytes),
            mode: mode,
            padding: padding.encryptPadding,
          ),
        ).decryptBytes(
          Encrypted(encrypted.bytes),
          iv: iv != null ? IV(iv.bytes) : null,
        ),
      );
}
