import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile(
      {Key? key,
      required this.title,
      required this.icon,
      required this.pressed})
      : super(key: key);
  final String title;
  final IconData icon;
  final VoidCallback pressed;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: pressed,
      horizontalTitleGap: 0.0,
      leading: Icon(
        icon,
        color: Colors.white54,
      ),
      title: Text(
        title,
        style: const TextStyle(
            color: Colors.white54, fontSize: 18, fontWeight: FontWeight.w100),
      ),
    );
  }
}
