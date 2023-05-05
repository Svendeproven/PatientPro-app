import 'package:another_flushbar/flushbar.dart';
import 'package:exam_app/components/drawer.dart';
import 'package:exam_app/components/waiting.dart';
import 'package:exam_app/models/user.dart';
import 'package:exam_app/services/auth.dart';
import 'package:exam_app/viewmodels/user_view_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// This is the main layout view
class LayoutView extends StatelessWidget {
  final Widget child;

  /// Constructor
  ///
  /// [child] is the child widget
  /// [key] is the key
  const LayoutView({super.key, required this.child});

  // override build method
  @override
  Widget build(BuildContext context) {
    // Start with a FutureBuilder to get the user
    return FutureBuilder<User?>(
        future:
            Provider.of<UserViewModel>(context, listen: false).getUserAsync(),
        builder: (context, snapshot) {
          User? user;
          if (snapshot.connectionState == ConnectionState.waiting) {
            // if we are waiting for the user, show a waiting widget
            return const Waiting();
          }
          if (snapshot.hasData) {
            user = snapshot.data!;
          }
          // if the user is null, remove the token and navigate to login
          if (user == null) {
            Auth.removeToken().then((value) =>
                Navigator.pushNamedAndRemoveUntil(
                    context, "/login", (route) => false));
          }
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: AppBar(
              title: const Text("PatientPro"),
              backgroundColor: Theme.of(context).colorScheme.background,
              elevation: 0,
              iconTheme: Theme.of(context).iconTheme,
              titleTextStyle: Theme.of(context).textTheme.titleLarge,
            ),
            drawer: const ExamDrawer(),
            body: SafeArea(
                child: Center(
              // Streambuilder to listen for notifications
              child: StreamBuilder<RemoteMessage>(
                  stream: FirebaseMessaging.onMessage,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // use a post frame callback to show the notification, which makes sure that the widget is built before showing the notification
                      WidgetsBinding.instance.addPostFrameCallback((_) async {
                        // show the notification
                        await Flushbar(
                          title: snapshot.data!.notification!.title,
                          flushbarPosition: FlushbarPosition.TOP,
                          message: snapshot.data!.notification!.body,
                          duration: const Duration(seconds: 5),
                        ).show(context);
                      });
                    }
                    return child;
                  }),
            )),
          );
        });
  }
}
