import 'package:exam_app/components/waiting.dart';
import 'package:exam_app/viewmodels/patient_journal_view_model.dart';
import 'package:exam_app/viewmodels/patient_medicines_view_model.dart';
import 'package:exam_app/viewmodels/patient_todo_view_model.dart';
import 'package:exam_app/viewmodels/patient_view_model.dart';
import 'package:exam_app/views/patient_journal_view.dart';
import 'package:exam_app/views/patient_medicine_view.dart';
import 'package:exam_app/views/patient_todo_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// View for patient
class PatientView extends StatefulWidget {
  const PatientView({super.key});

  @override
  State<PatientView> createState() => _PatientViewState();
}

/// State for patient view, which uses a SingleTickerProviderStateMixin to create a TabController
class _PatientViewState extends State<PatientView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // Create a TabController with 4 tabs
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  // override build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        iconTheme: Theme.of(context).iconTheme,
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
      ),
      body: SafeArea(
        // Consumer is a widget that listens to the PatientViewModel
        child: Consumer<PatientViewModel>(
          builder: (context, viewModel, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      viewModel.patient!.name,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Text(
                      viewModel.patient!.socialSecurityNumber,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),

              // TabBar with 4 tabs
              TabBar(
                labelColor: Theme.of(context).brightness == Brightness.light
                    ? Theme.of(context).colorScheme.primary
                    : Colors.white,
                tabs: const [
                  Tab(
                    text: "Generelt",
                    icon: Icon(Icons.person),
                  ),
                  Tab(
                    text: "Journal",
                    icon: Icon(Icons.book),
                  ),
                  Tab(
                    text: "Medicin",
                    icon: Icon(Icons.medication),
                  ),
                  Tab(
                    text: "Noter",
                    icon: Icon(Icons.note),
                  ),
                ],
                controller: _tabController,
              ),

              // The content of the view
              Expanded(
                // A FutureBuilder is used to wait for the data to be fetched before displaying the content
                child: FutureBuilder<Object>(
                    // The future is a list of futures, which are the fetch methods for the different viewmodels
                    future: Future.wait([
                      Provider.of<PatientMedicinesViewModel>(context,
                              listen: false)
                          .fetchPatientMedicinesAsync(
                              context, viewModel.patient!.id),
                      Provider.of<PatientTodoViewModel>(context, listen: false)
                          .fetchPatientTodosAsync(
                              context, viewModel.patient!.id),
                      Provider.of<PatientJournalViewModel>(context,
                              listen: false)
                          .fetchPatientJournalsAsync(
                              context, viewModel.patient!.id),
                    ]),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // If the data is not fetched yet, display a waiting widget
                        return const Waiting();
                      }
                      // The TabBarView is used to display the content of the different tabs
                      return TabBarView(
                        controller: _tabController,
                        children: [
                          const PatientTodoView(),
                          const PatientJournalView(),
                          PatientMedicineView(
                            patientId: viewModel.patient!.id,
                          ),
                          const Center(
                            child: Text("Noter"),
                          ),
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
