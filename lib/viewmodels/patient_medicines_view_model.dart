import 'package:exam_app/models/patient_medicine.dart';
import 'package:exam_app/services/api.dart';
import 'package:flutter/material.dart';

/// View model for patient medicines
class PatientMedicinesViewModel extends ChangeNotifier {
  // List of patient medicines
  List<PatientMedicine> _patientMedicines = [];

  /// Get patient medicines
  List<PatientMedicine> get patientMedicines => _patientMedicines;

  /// Set patient medicines
  ///
  /// [patientMedicines] is the patient medicines to set
  void setPatientMedicines(List<PatientMedicine> patientMedicines) {
    _patientMedicines = patientMedicines;
    notifyListeners();
  }

  /// Fetch the patient medicines by patient id async
  ///
  /// [context] is the context of the application
  /// [patientId] is the id of the patient
  /// Returns a list of [PatientMedicine]
  Future<List<PatientMedicine>> fetchPatientMedicinesAsync(
      BuildContext context, int patientId) async {
    var response = await Api.get("patientMedicine?patientmodelid=$patientId");
    if (response != null) {
      _patientMedicines = List<PatientMedicine>.from(
          response.map((x) => PatientMedicine.fromJson(x)));
      notifyListeners();
      return _patientMedicines;
    }
    return [];
  }
}
