import 'package:exam_app/models/patient_todo.dart';

/// PatientTodoWriteDTO is a data transfer object which is sent to the server on a patient todo write
class PatientTodoWriteDTO {
  int patientMedicineModelId; // Foreign key
  int userModelId; // Foreign key
  bool done;
  int patientModelId;
  DateTime plannedTimeAtDay;

  /// Constructor for creating a new patient todo write dto
  PatientTodoWriteDTO({
    required this.patientMedicineModelId,
    required this.userModelId,
    required this.done,
    required this.patientModelId,
    required this.plannedTimeAtDay,
  });

  /// Converts a json object to a PatientTodoWriteDTO object
  factory PatientTodoWriteDTO.fromJson(Map<String, dynamic> json) =>
      PatientTodoWriteDTO(
        patientMedicineModelId: json["PatientMedicineModelId"],
        userModelId: json["UserModelId"],
        done: json["Done"],
        patientModelId: json["PatientModelId"],
        plannedTimeAtDay: DateTime.parse(json["PlannedTimeAtDay"]),
      );

  // factory for creating a new patient todo from a patient todo model
  factory PatientTodoWriteDTO.fromPatientTodoModel(
      PatientTodo patientTodoModel, int userId) {
    return PatientTodoWriteDTO(
      patientMedicineModelId: patientTodoModel.patientMedicine!.id,
      userModelId: userId,
      done: patientTodoModel.done,
      patientModelId: patientTodoModel.patientMedicine!.patient.id,
      plannedTimeAtDay: patientTodoModel.plannedTimeAtDay,
    );
  }

  /// Converts a PatientTodoWriteDTO object to a json object
  Map<String, dynamic> toJson() => {
        "PatientMedicineModelId": patientMedicineModelId,
        "UserModelId": userModelId,
        "Done": done,
        "PatientModelId": patientModelId,
        "PlannedTimeAtDay": plannedTimeAtDay.toIso8601String(),
      };
}
