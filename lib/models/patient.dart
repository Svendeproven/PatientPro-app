/// Patient model
class Patient {
  int id;
  String name;
  String socialSecurityNumber;

  /// Constructor for creating a new patient
  Patient({
    required this.id,
    required this.name,
    required this.socialSecurityNumber,
  });

  /// Converts a json object to a Patient object
  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      name: json['name'],
      socialSecurityNumber: json['socialSecurityNumber'],
    );
  }

  /// Converts a Patient object to a json object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'socialSecurityNumber': socialSecurityNumber,
    };
  }
}
