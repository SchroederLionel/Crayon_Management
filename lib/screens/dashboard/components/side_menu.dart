import 'package:crayon_management/widgets/drawer_list_tile.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(child: Image.asset('assets/images/crayon.png')),
            DrawerListTile(
              title: 'Dashboard',
              icon: Icons.dashboard,
              pressed: () {},
            ),
            DrawerListTile(
              title: 'Profile',
              icon: Icons.account_circle,
              pressed: () {},
            ),
            DrawerListTile(
              title: 'Settings',
              icon: Icons.settings,
              pressed: () {},
            ),
            DrawerListTile(
              title: 'Logout',
              icon: Icons.logout,
              pressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
