import 'package:exam_app/components/waiting.dart';
import 'package:exam_app/viewmodels/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// This is the frontpage view
class FrontpageView extends StatelessWidget {
  const FrontpageView({super.key});

  // override the build method
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          // Consumer is a widget that listens to the UserViewModel
          Consumer<UserViewModel>(
            builder: ((context, value, child) {
              if (value.user == null) {
                // if the user is null, return the waiting widget
                return const Waiting();
              }
              return Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hej ${value.user!.name}",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Text(
                      value.user!.jobTitle,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ],
                ),
              );
            }),
          ),
          // Spacer
          const Expanded(child: SizedBox()),

          // Card with a button that navigates to the scan view
          Card(
              child: InkWell(
            onTap: () => Navigator.pushNamed(context, "/scan"),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.sick,
                    size: 50,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Patient håndtering",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          "Gå til en patient ved at scanne armbåndet eller indtaste manuelt",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),

          // Spacer
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
