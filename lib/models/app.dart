import 'package:flutter/foundation.dart';
import 'package:mytoolbox/models/user.dart';

class AppModel extends ChangeNotifier {
  bool _isLogin = false;
  bool get isLogin => _isLogin;

  late User _user;
  User get user => _user;

  void login() {
    _isLogin = true;
    _user = User.fromJson(Map<String, dynamic>.from(
        {'uid': '123456', 'name': 'test', 'email': ''}));
    notifyListeners();
  }

  void logout() {
    _isLogin = false;
    notifyListeners();
  }
}
