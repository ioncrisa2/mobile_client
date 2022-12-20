import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final storage = FlutterSecureStorage();
  final String tokenKey = 'token';

  //read token from storage
  Future<String> readToken() async {
    return await storage.read(key: tokenKey);
  }

  //save token to storage
  saveToken(String token) async {
    await storage.write(key: tokenKey, value: token);
  }

  deleteToken() async {
    await storage.delete(key: tokenKey);
  }
}
