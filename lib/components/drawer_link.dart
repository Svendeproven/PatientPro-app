import 'package:flutter/material.dart';

/// Drawer link widget used to display a link in the drawer
///
/// [context] is the current context
/// [title] is the title of the link
/// [route] is the route to push when the link is pressed
/// [icon] is the icon to display in front of the link
Widget drawerLink(
    BuildContext context, String title, String route, IconData icon) {
  return ListTile(
    leading: Icon(icon),
    title: Text(title),
    onTap: () => Navigator.pushReplacementNamed(context, route),
  );
}
