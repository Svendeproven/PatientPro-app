import 'package:exam_app/models/user.dart';

/// LoginDTO is a data transfer object which is recieved from the server on login
class LoginDTO {
  final String token;
  final User user;

  /// Constructor for creating a new login dto
  LoginDTO({
    required this.token,
    required this.user,
  });

  /// Converts a json object to a LoginDTO object
  factory LoginDTO.fromJson(Map<String, dynamic> json) {
    return LoginDTO(
      token: json['token'],
      user: User.fromJson(json['user']),
    );
  }
}
