import 'package:crayon_management/providers/user/user_provider.dart';
import 'package:crayon_management/providers/user/user_header_provider.dart';
import 'package:crayon_management/providers/util_providers/menu_provider.dart';
import 'package:crayon_management/responsive.dart';
import 'package:crayon_management/screens/dashboard/components/dashboard_main_screen.dart';
import 'package:crayon_management/screens/dashboard/menu/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(
        (_) => Provider.of<UserProvider>(context, listen: false).getUserData());
  }

  @override
  Widget build(BuildContext context) {
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
