import 'package:encrypt/encrypt.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EncryptHelper {
  static String encrypt(String plainText) {
    final key = Key.fromUtf8(dotenv.env["ENCRYPT_KEY"]!);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  static String decrypt(String encryptedText) {
    final key = Key.fromUtf8(dotenv.env["ENCRYPT_KEY"]!);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    final decrypted =
        encrypter.decrypt(Encrypted.fromBase64(encryptedText), iv: iv);
    return decrypted;
  }
}
