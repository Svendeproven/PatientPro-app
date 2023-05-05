import 'package:flutter/material.dart';

/// This is a card button that can be used to navigate to a new route
class ScanCardButton extends StatelessWidget {
  final Function()? onTab;
  final String title;
  final String subtitle;
  final IconData icon;

  /// Constructor
  ///
  /// [onTab] is the function to call when the card is tapped
  /// [title] is the title of the card
  /// [subtitle] is the subtitle of the card
  /// [icon] is the icon of the card
  const ScanCardButton(
      {super.key,
      required this.onTab,
      required this.title,
      required this.subtitle,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTab,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Icon(icon)
            ],
          ),
        ),
      ),
    );
  }
}
