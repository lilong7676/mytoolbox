import 'dart:math';

class User {
  final String uid;
  final String email;
  final String name;

  // 使用json初始化 user
  User.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        email = json['email'],
        name = json['name'];

  static User mock() {
    return User.fromJson({
      // 随机 uid
      'uid': Random().nextInt(100000).toString(),
      'email': 'testEmail@outlook.com',
      'name': 'lilonglong',
    });
  }
}
