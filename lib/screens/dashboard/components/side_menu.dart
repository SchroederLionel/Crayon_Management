import 'package:crayon_management/providers/theme_provider.dart';
import 'package:crayon_management/widgets/drawer_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Drawer(
      elevation: 16,
      child: Container(
        color: const Color(0xFF2A2D3E),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DrawerHeader(
                  child: Image.asset(
                'assets/images/crayon.png',
                fit: BoxFit.fill,
              )),
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
              Consumer<ThemeProvider>(
                builder: (context, theme, child) => DrawerListTile(
                  title: 'Brightness',
                  icon: Icons.lightbulb_outline,
                  pressed: () {
                    themeProvider.swapTheme();
                  },
                ),
              ),
              DrawerListTile(
                title: 'Logout',
                icon: Icons.logout,
                pressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
