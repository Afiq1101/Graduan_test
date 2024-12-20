
class User {
  int id;
  String name;
  String email;
  DateTime emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      emailVerifiedAt: DateTime.parse(json['email_verified_at']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory User.create({
    required int id,
    required String name,
    required String email,
  }) {
    return User(
      id: id,
      name: name,
      email: email,
      emailVerifiedAt: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}

class ReturnUser {
  final String text;
  final bool success;
  final User? user;

  ReturnUser({
    required this.text,
    required this.success,
    required this.user,
  });

}
