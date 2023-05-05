import 'package:exam_app/components/error_dialog.dart';
import 'package:exam_app/models/patient.dart';
import 'package:exam_app/services/api.dart';
import 'package:flutter/material.dart';

/// View model for patient
class PatientViewModel extends ChangeNotifier {
  // Patient
  Patient? _patient;

  /// Get patient
  Patient? get patient => _patient;

  /// Set patient
  ///
  /// [patient] is the patient to set
  void setPatient(Patient patient) {
    _patient = patient;
    notifyListeners();
  }

  /// Fetch patient by social security number async
  ///
  /// [context] is the context of the application
  /// [ssn] is the social security number of the patient
  /// Returns a [Patient]
  Future<Patient?> getPatientBySsnAsync(
      BuildContext context, String? ssn) async {
    // Check if ssn is null
    if (ssn == null) {
      return null;
    }
    // Validate ssn
    if (ssn.isEmpty) {
      await showErrorDialog(context, "Ugyldigt CPR-nummer");
      return null;
    }

    // Fetch patient
    var response = await Api.get("patient/$ssn");

    // Check if a patient was found
    if (response != null) {
      _patient = Patient.fromJson(response);
      notifyListeners();
      return _patient;
    }

    // No patient was found, show error dialog
    // ignore: use_build_context_synchronously
    await showErrorDialog(
        context, "Der blev ikke fundet en patient med det CPR-nummer");

    return null;
  }
}
