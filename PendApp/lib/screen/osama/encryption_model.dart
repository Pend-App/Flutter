import 'package:encrypt/encrypt.dart';

const int KEncryptKeyLength = 32;
const int KEncryptIvLength = 16;

///takes plainText and return String encryptedText
///in according to const key and iv
String encrypt(String plainText) {

  final key = Key.fromLength(KEncryptKeyLength);
  final iv = IV.fromLength(KEncryptIvLength);
  final encryptor = Encrypter(AES(key));

  final encrypted = encryptor.encrypt(plainText, iv: iv);


  //test encryption
  // print(decrypted);
  print(encrypted.bytes);
  print(encrypted.base16);
  print(encrypted.base64);

  return encrypted.base64;
}

String decrypt (String encryptedText){
  final key = Key.fromLength(KEncryptKeyLength);
  final iv = IV.fromLength(KEncryptIvLength);
  final encryptor = Encrypter(AES(key));

  return encryptor.decrypt(Encrypted.from64(encryptedText), iv: iv);
}