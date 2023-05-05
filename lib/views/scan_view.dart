// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:exam_app/components/nfc_modal_bottom_sheet.dart';
import 'package:exam_app/components/scan_card_button.dart';
import 'package:exam_app/components/ssn_input_dialog.dart';
import 'package:exam_app/models/patient.dart';
import 'package:exam_app/services/nfc_scanner.dart';
import 'package:exam_app/viewmodels/patient_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// View for scanning
class ScanView extends StatelessWidget {
  const ScanView({super.key});

  // override build method
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Scan",
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ],
          ),

          // Manually enter ssn
          ScanCardButton(
            onTab: () async {
              var res = await showDialog(
                  context: context,
                  builder: (context) => const SsnInputDialog());
              Patient? patient =
                  await Provider.of<PatientViewModel>(context, listen: false)
                      .getPatientBySsnAsync(context, res);
              if (patient != null) {
                Navigator.pushNamed(context, "/patient");
              }
            },
            title: "CPR-nummer",
            subtitle: "Indtast CPR-nummer på patienten manuelt",
            icon: Icons.text_fields,
          ),

          // Scan QR-code
          ScanCardButton(
            onTab: () => Navigator.pushNamed(context, "/qr"),
            title: "QR-kode",
            subtitle: "Scan QR-koden på patientens armbånd",
            icon: Icons.qr_code,
          ),

          // Scan NFC-chip
          FutureBuilder<bool>(
              future: Provider.of<NfcScanner>(context).isNFCAvailable(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                }
                if (snapshot.hasData) {
                  if (!snapshot.data!) {
                    return Container();
                  }
                }
                return ScanCardButton(
                    onTab: () async {
                      NfcScanner nfcScanner =
                          Provider.of<NfcScanner>(context, listen: false);
                      String? res;
                      // Check if device is Android or iOS
                      if (Platform.isAndroid) {
                        res = await showModalBottomSheet<String>(
                            isDismissible: false,
                            enableDrag: false,
                            context: context,
                            builder: (context) => const NfcModalBottomSheet());
                      } else {
                        res = await nfcScanner.readNfcTag();
                      }

                      // Try to fetch patient by ssn
                      Patient? patient = await Provider.of<PatientViewModel>(
                              context,
                              listen: false)
                          .getPatientBySsnAsync(context, res);
                      if (patient != null) {
                        Navigator.pushNamed(context, "/patient");
                      }
                    },
                    title: "NFC-chip",
                    subtitle: "Scan NFC-chippen på patientens armbånd",
                    icon: Icons.nfc);
              }),
        ],
      ),
    );
  }
}
