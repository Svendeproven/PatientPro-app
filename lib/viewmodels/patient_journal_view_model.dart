import 'package:exam_app/models/patient_journal.dart';
import 'package:exam_app/services/api.dart';
import 'package:flutter/material.dart';

/// View model for patient journal
class PatientJournalViewModel extends ChangeNotifier {
  // List of patient journals
  List<PatientJournal> _patientJournals = [];

  /// Get patient journals
  List<PatientJournal> get patientJournals => _patientJournals;

  /// Fetch the patient journals by patient id async
  ///
  /// [context] is the context of the application
  /// [patientId] is the id of the patient
  /// Returns a list of [PatientJournal]
  Future<List<PatientJournal>> fetchPatientJournalsAsync(
      BuildContext context, int patientId) async {
    var response = await Api.get("patientjournal?patientmodelId=$patientId");
    if (response != null) {
      var patientJournals = List<PatientJournal>.from(
          response.map((x) => PatientJournal.fromJson(x)));
      _patientJournals = patientJournals;
      notifyListeners();
    }
    return patientJournals;
  }
}
