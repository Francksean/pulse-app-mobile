import 'package:hive_flutter/adapters.dart';

class HiveService {
  final Box _box = Hive.box('userBox');

  static Future<void> ensureInitialized() async {
    if (!Hive.isBoxOpen('userBox')) {
      await Hive.initFlutter();
      await Hive.openBox('userBox');
    }
  }

  void saveUsername(String username) {
    _box.put('username', username);
  }

  void saveToken(String token) {
    _box.put('token', token);
  }

  void saveUserId(String id) {
    _box.put("userId", id);
  }

  // void savePassword(String password) {
  //   _box.put('password', password);
  // }

  String? getUsername() {
    return _box.get('username');
  }

  String? getToken() {
    return _box.get('token');
  }

  String? getUserId() {
    return _box.get("userId");
  }

  // String? getPassword() {
  //   return _box.get('password');
  // }
}
