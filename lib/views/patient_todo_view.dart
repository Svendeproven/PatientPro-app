import 'package:exam_app/components/confirm_dialog.dart';
import 'package:exam_app/viewmodels/patient_todo_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

/// View for patient todos
class PatientTodoView extends StatelessWidget {
  const PatientTodoView({super.key});

  // override build method
  @override
  Widget build(BuildContext context) {
    // Consumer is a widget that listens to the PatientTodoViewModel
    return Consumer<PatientTodoViewModel>(
        builder: (context, patientTodoViewModel, child) {
      return ListView.builder(
        itemCount: patientTodoViewModel.patientTodos.length,
        itemBuilder: (context, index) {
          var patientTodo = patientTodoViewModel.patientTodos[index];
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Checkbox(
                    side: BorderSide(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black),

                    // Set fill color to primary color
                    activeColor: Theme.of(context).colorScheme.secondary,
                    value: patientTodo.done,
                    onChanged: (value) async {
                      // If the checkbox is checked, update the patient todo
                      if (value == true) {
                        patientTodo.done = value!;
                        await patientTodoViewModel.updatePatientTodoAsync(
                            context, patientTodo);
                      } else {
                        // Confirm dialog to uncheck the checkbox
                        var confirm = await confirmDialog(context,
                            title: "Bekræft", content: "Er du helt sikker?");
                        if (confirm) {
                          patientTodo.done = value!;
                          // ignore: use_build_context_synchronously
                          await patientTodoViewModel.updatePatientTodoAsync(
                              context, patientTodo);
                        }
                      }
                    },
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      patientTodo.patientMedicine!.medicine.title,
                      style: TextStyle(
                        decoration: patientTodo.done
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    Text(
                      DateFormat('kk:mm - dd.MM.yyyy')
                          .format(patientTodoViewModel
                              .patientTodos[index].plannedTimeAtDay)
                          .toString(),
                      style: TextStyle(
                        decoration: patientTodo.done
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
                Text(
                  patientTodoViewModel
                          .patientTodos[index].patientMedicine!.amount
                          .toString() +
                      patientTodoViewModel
                          .patientTodos[index].patientMedicine!.unit,
                  style: TextStyle(
                    decoration: patientTodo.done
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
