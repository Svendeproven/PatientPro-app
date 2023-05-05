import 'package:exam_app/models/patient.dart';
import 'package:exam_app/models/user.dart';

/// Department model
class Department {
  int id;
  String title;
  List<User> users;
  List<Patient> patients;

  /// Constructor for creating a new department
  Department({
    required this.id,
    required this.title,
    required this.users,
    required this.patients,
  });

  /// Converts a json object to a Department object
  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'],
      title: json['title'],
      users: List<User>.from(json['users'].map((x) => User.fromJson(x))),
      patients:
          List<Patient>.from(json['patients'].map((x) => Patient.fromJson(x))),
    );
  }

  /// Converts a Department object to a json object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'users': List<dynamic>.from(users.map((x) => x.toJson())),
      'patients': List<dynamic>.from(patients.map((x) => x.toJson())),
    };
  }
}
