import 'package:exam_app/models/patient_medicine.dart';

/// PatientTodo model
class PatientTodo {
  int id;
  PatientMedicine? patientMedicine;
  bool done;
  DateTime plannedTimeAtDay;
  int patientModelId;

  /// Constructor for creating a new patient todo
  PatientTodo({
    required this.id,
    required this.patientMedicine,
    required this.done,
    required this.plannedTimeAtDay,
    required this.patientModelId,
  });

  /// Converts a json object to a PatientTodo object
  factory PatientTodo.fromJson(Map<String, dynamic> json) => PatientTodo(
        id: json["id"],
        patientMedicine: PatientMedicine.fromJson(json["patientMedicine"]),
        done: json["done"],
        plannedTimeAtDay: DateTime.parse(json["plannedTimeAtDay"]),
        patientModelId: json["patientModelId"],
      );

  /// Converts a PatientTodo object to a json object
  Map<String, dynamic> toJson() => {
        "id": id,
        "patientMedicine": patientMedicine!.toJson(),
        "done": done,
        "plannedTimeAtDay": plannedTimeAtDay.toIso8601String(),
      };
}
