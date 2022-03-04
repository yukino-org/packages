import '../../model.dart';
import 'binding.dart';

final HetuHelperClass hCryptoClass = HetuHelperClass(
  definition: CryptoClassBinding(),
  declaration: '''
external class Crypto {
  /// (BytesContainer) => BytesContainer
  static fun md5Convert(data);

  /// ({
  ///   input: BytesContainer,
  ///   key: BytesContainer,
  ///   iv: BytesContainer?,
  ///   mode: 'cbc' | 'cfb64' | 'ctr' | 'ecb' | 'ofb64Gctr' | 'ofb64' | 'sic' = 'sic',
  ///   padding: 'none' | 'pkcs7',
  /// }) => BytesContainer;
  static fun aesEncrypt({ input, key, iv, mode, padding });

  /// ({
  ///   encrypted: BytesContainer,
  ///   key: BytesContainer,
  ///   iv: BytesContainer?,
  ///   mode: 'cbc' | 'cfb64' | 'ctr' | 'ecb' | 'ofb64Gctr' | 'ofb64' | 'sic' = 'sic',
  ///   padding: 'none' | 'pkcs7',
  /// }) => BytesContainer;
  static fun aesDecrypt({ encrypted, key, iv, mode, padding });
}
      '''
      .trim(),
);
