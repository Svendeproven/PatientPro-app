import 'package:exam_app/models/department.dart';
import 'package:exam_app/services/api.dart';
import 'package:flutter/material.dart';

/// View model for department
class DepartmentViewModel extends ChangeNotifier {
  Department? _department;

  /// Get department
  Department? get department => _department;

  /// Set department
  ///
  /// [department] is the department to set
  void setDepartment(Department department) {
    _department = department;
    notifyListeners();
  }

  /// Fetch department by id
  ///
  /// [departmentId] is the id of the department
  /// Returns a [Department]
  Future<Department?> getDepartmentAsync(int departmentId) async {
    var response = await Api.get("department/$departmentId");
    if (response != null) {
      _department = Department.fromJson(response);
      notifyListeners();
    }
    return _department;
  }
}
