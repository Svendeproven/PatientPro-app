import 'package:exam_app/models/patient_journal.dart';
import 'package:exam_app/viewmodels/patient_journal_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

/// View for patient journals
class PatientJournalView extends StatelessWidget {
  const PatientJournalView({super.key});

  // override build method
  @override
  Widget build(BuildContext context) {
    // Consumer is a widget that listens to the PatientJournalViewModel
    return Consumer<PatientJournalViewModel>(
        builder: (context, patientJournalViewModel, child) {
      List<PatientJournal> patientJournals =
          patientJournalViewModel.patientJournals;
      return ListView.builder(
        itemCount: patientJournals.length,
        itemBuilder: (context, index) => Card(
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(20),
                child: Icon(Icons.book),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('dd.MM.yyyy')
                        .format(patientJournals[index].createdAt),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(patientJournals[index].description,
                      style: Theme.of(context).textTheme.labelSmall),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
