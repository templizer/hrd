class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.avatar,
    required this.workspace_type,
  });

  factory User.fromJson(dynamic json) {
    return User(
        id: json['id'] ?? 0,
        name: json['name'].toString() ?? "",
        email: json['email'].toString() ?? "",
        username: json['username'].toString() ?? "",
        avatar: json['avatar'].toString() ?? "",
        workspace_type: json['workspace_type'].toString() ?? "");
  }

  final int id;
  final String name;
  final String email;
  final String username;
  final String avatar;
  final String workspace_type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['username'] = username;
    map['avatar'] = avatar;
    return map;
  }
}
