import 'package:exam_app/models/medicine.dart';
import 'package:exam_app/models/patient.dart';

/// PatientMedicine model
class PatientMedicine {
  int id;
  Patient patient;
  Medicine medicine;
  int amount;
  String unit;

  /// Constructor for creating a new patient medicine
  PatientMedicine({
    required this.id,
    required this.patient,
    required this.medicine,
    required this.amount,
    required this.unit,
    // required this.todos,
  });

  /// Converts a json object to a PatientMedicine object
  factory PatientMedicine.fromJson(Map<String, dynamic> json) =>
      PatientMedicine(
        id: json["id"],
        patient: Patient.fromJson(json["patient"]),
        medicine: Medicine.fromJson(json["medicine"]),
        amount: json["amount"],
        unit: json["unit"],
        // todos: List<dynamic>.from(json["todos"].map((x) => x)),
      );

  /// Converts a PatientMedicine object to a json object
  Map<String, dynamic> toJson() => {
        "id": id,
        "patient": patient.toJson(),
        "medicine": medicine.toJson(),
        "amount": amount,
        "unit": unit,
      };
}
