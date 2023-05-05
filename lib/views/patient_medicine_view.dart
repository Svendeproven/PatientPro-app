import 'package:exam_app/models/patient_medicine.dart';
import 'package:exam_app/viewmodels/patient_medicines_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// View for patient medicines
class PatientMedicineView extends StatelessWidget {
  final int patientId;
  const PatientMedicineView({super.key, required this.patientId});

  // override build method
  @override
  Widget build(BuildContext context) {
    // Consumer is a widget that listens to the PatientMedicinesViewModel
    return Consumer<PatientMedicinesViewModel>(
        builder: (context, patientMedicinesViewModel, child) {
      List<PatientMedicine> patientMedicines =
          patientMedicinesViewModel.patientMedicines;
      return ListView.builder(
        itemCount: patientMedicines.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(Icons.medical_services),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(patientMedicines[index].medicine.title),
                    Text(patientMedicines[index].medicine.activeSubstance),
                  ],
                ),
                const Expanded(child: SizedBox()),
                Text(patientMedicines[index].amount.toString() +
                    patientMedicines[index].unit),
              ],
            ),
          );
        },
      );
    });
  }
}
