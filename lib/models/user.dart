/// User model
class User {
  final int id;
  final String name;
  final String email;
  final String role;
  final String jobTitle;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int departmentModelId;

  /// Constructor for creating a new user
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.jobTitle,
    required this.createdAt,
    required this.updatedAt,
    required this.departmentModelId,
  });

  /// Converts a json object to a User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      jobTitle: json['jobTitle'] ?? "Sygeplejerske",
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      departmentModelId: json['departmentModelId'],
    );
  }

  /// Converts a User object to a json object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'jobTitle': jobTitle,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'departmentModelId': departmentModelId,
    };
  }
}
