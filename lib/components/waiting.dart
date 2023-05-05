import 'package:flutter/material.dart';

/// Waiting is a component used for when the app is waiting for something
class Waiting extends StatelessWidget {
  const Waiting({super.key});

  /// override build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            Text("Loading..."),
          ],
        ),
      )),
    );
  }
}
