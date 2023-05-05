import 'package:exam_app/services/auth.dart';
import 'package:exam_app/views/login_view.dart';
import 'package:flutter/material.dart';

/// A wrapper for routes that require authentication
class PrivateRoute extends StatelessWidget {
  final Widget next;
  const PrivateRoute({super.key, required this.next});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Auth.getToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Placeholder();
          }
          if (snapshot.hasData) {
            return next;
          } else {
            return const LoginView();
          }
        });
  }
}
