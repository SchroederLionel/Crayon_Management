import 'package:crayon_management/datamodels/user/user_data.dart';
import 'package:crayon_management/providers/login_registration_provider/user_provider.dart';
import 'package:crayon_management/providers/util_providers/menu_provider.dart';
import 'package:crayon_management/responsive.dart';
import 'package:crayon_management/screens/dashboard/components/dashboard_main_screen.dart';
import 'package:crayon_management/screens/dashboard/menu/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  final UserData userData;
  const Dashboard({required this.userData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context, listen: false).setUserData(userData);
    return Scaffold(
      drawer: const SideMenu(),
      key: context.read<MenuProvider>().scaffoldKey,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              const Expanded(flex: 1, child: SideMenu()),
            const Expanded(flex: 5, child: DashboardMainScreen())
          ],
        ),
      ),
    );
  }
}
