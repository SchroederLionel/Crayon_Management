import 'package:crayon_management/datamodels/user/user_data.dart';
import 'package:crayon_management/l10n/app_localizations.dart';
import 'package:crayon_management/providers/login_registration_provider/user_provider.dart';

import 'package:crayon_management/screens/dashboard/menu/drawer_list_tile.dart';
import 'package:crayon_management/screens/dashboard/menu/profile_dialog.dart';
import 'package:crayon_management/screens/dashboard/menu/settings_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appTranslation = AppLocalizations.of(context);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
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
                height: 100,
                width: 150,
              )),
              DrawerListTile(
                title: appTranslation!.translate('dashboard') ?? 'Dashboard',
                icon: Icons.dashboard,
                pressed: () {},
              ),
              DrawerListTile(
                title: appTranslation.translate('profile') ?? 'Profile',
                icon: Icons.account_circle,
                pressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const ProfileDialog();
                      }).then((value) {
                    if (value is UserData) {
                      userProvider.updateUserData(value);
                    }
                  });
                },
              ),
              DrawerListTile(
                title: appTranslation.translate('settings') ?? 'Settings',
                icon: Icons.settings,
                pressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          const SettingsDialog());
                },
              ),
              DrawerListTile(
                title: appTranslation.translate('logout') ?? 'Logout',
                icon: Icons.logout,
                pressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
