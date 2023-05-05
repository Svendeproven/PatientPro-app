import 'package:exam_app/services/nfc_scanner.dart';
import 'package:exam_app/services/private_route.dart';
import 'package:exam_app/theme/dark_theme.dart';
import 'package:exam_app/theme/theme.dart';
import 'package:exam_app/viewmodels/department_view_model.dart';
import 'package:exam_app/viewmodels/holograms_view_model.dart';
import 'package:exam_app/viewmodels/medicine_view_model.dart';
import 'package:exam_app/viewmodels/patient_journal_view_model.dart';
import 'package:exam_app/viewmodels/patient_medicines_view_model.dart';
import 'package:exam_app/viewmodels/patient_todo_view_model.dart';
import 'package:exam_app/viewmodels/patient_view_model.dart';
import 'package:exam_app/viewmodels/user_view_model.dart';
import 'package:exam_app/views/department_view.dart';
import 'package:exam_app/views/frontpage_view.dart';
import 'package:exam_app/views/holograms_view.dart';
import 'package:exam_app/views/layout_view.dart';
import 'package:exam_app/views/login_view.dart';
import 'package:exam_app/views/medicine_view.dart';
import 'package:exam_app/views/patient_view.dart';
import 'package:exam_app/views/qr_scan_view.dart';
import 'package:exam_app/views/scan_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  // Load .env file
  await dotenv.load(fileName: ".env");

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  await messaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: false,
    criticalAlert: true,
    provisional: false,
    sound: true,
  );

  runApp(
    // Prepares NfcScanner for dependency injection via provider pattern
    MultiProvider(
      providers: [
        Provider(
          create: (context) => NfcScanner(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => MedicineViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => PatientViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => PatientMedicinesViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => PatientTodoViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => PatientJournalViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => DepartmentViewModel(),
        ),
        Provider(
          create: (context) => HologramsViewModel(),
        ),
      ],
      child: const MyApp(),
    ),
  );

  initState();
}

initState() {
  Future.delayed(const Duration(milliseconds: 500), () {
    FlutterNativeSplash.remove();
    // log to console to see if it works
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Svendeprøven',
      theme: themeData,
      darkTheme: darktheme,
      routes: {
        '/': (context) => const PrivateRoute(
                next: LayoutView(
              child: FrontpageView(),
            )),
        '/department': (context) => const PrivateRoute(
                next: LayoutView(
              child: DepartmentView(),
            )),
        '/medicine': (context) => const PrivateRoute(
                next: LayoutView(
              child: MedicineView(),
            )),
        '/scan': (context) => const PrivateRoute(
                next: LayoutView(
              child: ScanView(),
            )),
        '/holograms': (context) => const PrivateRoute(
                next: LayoutView(
              child: HologramsView(),
            )),
        '/qr': (context) => const PrivateRoute(next: QrScanView()),
        '/patient': (context) => const PrivateRoute(next: PatientView()),
        '/login': (context) => const LoginView(),
      },
    );
  }
}
