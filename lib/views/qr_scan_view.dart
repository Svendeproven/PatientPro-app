import 'package:exam_app/models/patient.dart';
import 'package:exam_app/viewmodels/patient_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

/// This is the view for scanning a QR code
class QrScanView extends StatefulWidget {
  const QrScanView({super.key});

  @override
  State<QrScanView> createState() => _QrScanViewState();
}

/// This is the state for the QR scan view
class _QrScanViewState extends State<QrScanView> {
  // Global key for the QR view
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // Controller for the QR view
  QRViewController? controller;
  // Result from the QR scan
  Barcode? result;

  /// This method is called when the QR view is created
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      // When a QR code is scanned, pause the camera and dispose the controller
      controller.pauseCamera();
      controller.dispose();
      // Get the patient by the scanned QR code
      Patient? patient =
          await Provider.of<PatientViewModel>(context, listen: false)
              .getPatientBySsnAsync(context, scanData.code);
      // If the patient is not null, navigate to the patient view
      if (patient != null) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, "/patient");
      } else {
        // No patient was found, pop the QR scan view
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    // Dispose the controller
    controller?.dispose();
    super.dispose();
  }

  // override build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Center(
                child: QRView(
                    key: qrKey,
                    onQRViewCreated: _onQRViewCreated,
                    overlay: QrScannerOverlayShape(
                      borderColor: Colors.red,
                      borderRadius: 10,
                      borderLength: 30,
                      borderWidth: 10,
                      cutOutSize: 300,
                    )),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Icon(
                      Icons.qr_code,
                      size: 84,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Scan QR-kode",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const Text("Scan QR-koden på patientens armbånd"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
