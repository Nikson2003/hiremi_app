import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onMenuTap;
  final VoidCallback onNotificationTap;

  TopBar({
    required this.title,
    required this.onMenuTap,
    required this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: onNotificationTap,
        ),
      ],
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: onMenuTap,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
