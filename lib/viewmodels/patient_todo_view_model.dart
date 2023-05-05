import 'package:exam_app/models/dto/patient_todo_write_dto.dart';
import 'package:exam_app/models/patient_todo.dart';
import 'package:exam_app/services/api.dart';
import 'package:exam_app/viewmodels/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// View model for patient todos
class PatientTodoViewModel extends ChangeNotifier {
  // List of patient todos
  List<PatientTodo> _patientTodos = [];

  /// Get patient todos
  List<PatientTodo> get patientTodos => _patientTodos;

  /// Set patient todos
  ///
  /// [patientTodos] is the list of patient todos
  void setPatientTodos(List<PatientTodo> patientTodos) {
    _patientTodos = patientTodos;
    notifyListeners();
  }

  /// Fetch the patient todos by patient id async
  ///
  /// [context] is the context of the application
  /// [patientId] is the id of the patient
  /// Returns a list of [PatientTodo]
  Future<List<PatientTodo>> fetchPatientTodosAsync(
      BuildContext context, int patientId) async {
    var response = await Api.get("patientTodo?patientmodelid=$patientId");
    if (response != null) {
      _patientTodos =
          List<PatientTodo>.from(response.map((x) => PatientTodo.fromJson(x)));
      notifyListeners();
      return _patientTodos;
    }
    return [];
  }

  /// Update the patient todo async
  ///
  /// [context] is the context of the application
  /// [patientTodo] is the patient todo to update
  /// Returns a list of [PatientTodo]
  Future<List<PatientTodo>> updatePatientTodoAsync(
      BuildContext context, PatientTodo patientTodo) async {
    // Get the user from the user provider
    var user = Provider.of<UserViewModel>(context, listen: false).user;

    // Create a PatientTodoWriteDTO
    PatientTodoWriteDTO patientTodoWriteDTO =
        PatientTodoWriteDTO.fromPatientTodoModel(patientTodo, user!.id);

    var response = await Api.put(
        "patientTodo/${patientTodo.id}", patientTodoWriteDTO.toJson());
    if (response != null) {
      var index = _patientTodos.indexWhere((x) => x.id == patientTodo.id);
      _patientTodos[index] = patientTodo;
      notifyListeners();
    }
    return _patientTodos;
  }
}
