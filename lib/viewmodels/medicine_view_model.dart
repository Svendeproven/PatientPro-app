import 'package:exam_app/models/medicine.dart';
import 'package:exam_app/services/api.dart';
import 'package:flutter/material.dart';

/// View model for medicine
class MedicineViewModel extends ChangeNotifier {
  // List of medicins
  List<Medicine> _medicines = [];

  /// Get medicins
  List<Medicine> get medicines => _medicines;

  /// Future for fetching all medicins
  ///
  /// Returns a list of [Medicine]
  Future<List<Medicine>> fetchMedicinesAsync() async {
    var response = await Api.get("medicine");
    _medicines = List<Medicine>.from(
        response!.map((medicine) => Medicine.fromJson(medicine)));
    notifyListeners();
    return _medicines;
  }
}
