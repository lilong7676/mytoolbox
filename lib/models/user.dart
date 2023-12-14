class User {
  final String uid;
  final String email;
  final String name;

  // 使用json初始化 user
  User.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        email = json['email'],
        name = json['name'];
}
