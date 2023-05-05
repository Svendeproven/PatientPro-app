import 'package:exam_app/services/nfc_scanner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// NfcModalBottomSheet is a widget used to display a bottom sheet for scanning nfc tags
class NfcModalBottomSheet extends StatelessWidget {
  const NfcModalBottomSheet({super.key});

  /// override build method
  @override
  Widget build(BuildContext context) {
    // Listen to the readNfcTag method in the NfcScanner
    return FutureBuilder<String?>(
        future: Provider.of<NfcScanner>(context, listen: false).readNfcTag(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display this when waiting for the future to complete

            return Container(
              color: Theme.of(context).colorScheme.background,
              child: Center(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor:
                                Theme.of(context).colorScheme.error,
                          ),
                          onPressed: () => Navigator.pop(context, null),
                          child: const Text("Annuller"),
                        ),
                      ),
                    ),

                    // NFC gif
                    const Expanded(
                        child: Image(image: AssetImage("assets/gif/nfc2.gif"))),

                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.nfc,
                            size: 84,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Scan NFC-chip",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const Text(
                                    "Scan NFC-chippen på patientens armbånd"),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          // If the snapshot has data, pop the bottom sheet and return the data
          if (snapshot.hasData) {
            Navigator.pop(context, snapshot.data);
          }

          // Default to returning an empty container
          return Container();
        });
  }
}
