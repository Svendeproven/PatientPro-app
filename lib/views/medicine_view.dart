import 'package:exam_app/components/waiting.dart';
import 'package:exam_app/models/medicine.dart';
import 'package:exam_app/viewmodels/medicine_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// View for medicine
class MedicineView extends StatelessWidget {
  const MedicineView({super.key});

  // override build method
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              Text(
                "Medicin",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const Expanded(child: SizedBox()),
              IconButton(onPressed: () => {}, icon: const Icon(Icons.add))
            ],
          ),
        ),
        Expanded(
          // FutureBuilder is a widget that listens to the MedicineViewModel
          child: FutureBuilder<List<Medicine>>(
              future: Provider.of<MedicineViewModel>(context, listen: false)
                  .fetchMedicinesAsync(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // if the connection state is waiting, return the waiting widget
                  return const Waiting();
                }

                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }

                // Get the medicins from the snapshot
                List<Medicine> medicins = snapshot.data!;

                return ListView.builder(
                    itemCount: medicins.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(20),
                              child: Icon(Icons.medication),
                            ),
                            Text(medicins[index].title),
                            const Expanded(child: SizedBox()),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text("${medicins[index].pricePrMg},- DKK"),
                            ),
                          ],
                        ),
                      );
                    });
              }),
        ),
      ],
    );
  }
}
