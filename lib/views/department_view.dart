import 'package:exam_app/components/waiting.dart';
import 'package:exam_app/models/department.dart';
import 'package:exam_app/models/patient.dart';
import 'package:exam_app/viewmodels/department_view_model.dart';
import 'package:exam_app/viewmodels/patient_view_model.dart';
import 'package:exam_app/viewmodels/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// This is the view for the department
class DepartmentView extends StatelessWidget {
  const DepartmentView({super.key});

  /// override build method
  @override
  Widget build(BuildContext context) {
    int departmentId = context.watch<UserViewModel>().user!.departmentModelId;
    return FutureBuilder<Department?>(
        future: Provider.of<DepartmentViewModel>(context, listen: false)
            .getDepartmentAsync(departmentId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show waiting widget if waiting for data
            return const Waiting();
          }
          if (snapshot.hasError) {
            // Show error text if error
            return const Text("Error");
          }

          // Get department from snapshot
          Department department = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  department.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  "Ansatte",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.work),
                    title: const Text("Ansatte"),
                    trailing: Text(department.users.length.toString()),
                  ),
                ),
                Text(
                  "Patienter",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Expanded(
                    child: ListView.builder(
                  itemBuilder: (context, index) {
                    Patient patient = department.patients[index];
                    return Card(
                      child: ListTile(
                        title: Text(patient.name),
                        subtitle: Text(
                            "${patient.socialSecurityNumber.substring(0, 7)}XXXX"),
                        trailing: const Icon(Icons.arrow_forward),
                        onTap: () async {
                          Patient? p = await Provider.of<PatientViewModel>(
                                  context,
                                  listen: false)
                              .getPatientBySsnAsync(
                                  context, patient.socialSecurityNumber);
                          if (p != null) {
                            // ignore: use_build_context_synchronously
                            Navigator.pushNamed(context, "/patient");
                          }
                        },
                      ),
                    );
                  },
                  itemCount: department.patients.length,
                )),
              ],
            ),
          );
        });
  }
}
