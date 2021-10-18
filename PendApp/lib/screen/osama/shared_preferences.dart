import 'package:shared_preferences/shared_preferences.dart';
import 'encryption_model.dart';

///saves users keys into shared preferences
Future<bool> setKeys(String publicKey, String privateKey) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.setStringList('keys', [encrypt(publicKey), encrypt(privateKey)]);
}

///returns a List<String> [publicKey, privateKey] if it finds the keys, otherwise it returns null
Future? getKeys() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? keys = await prefs.getStringList('keys');

  return keys != null ? [decrypt(keys[0]), decrypt(keys[1])] : null;
}
