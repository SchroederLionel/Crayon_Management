import 'package:crayon_management/providers/menu_provider.dart';
import 'package:crayon_management/responsive.dart';
import 'package:crayon_management/screens/dashboard/components/dashboard_main_screen.dart';
import 'package:crayon_management/screens/dashboard/components/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context, listen: false);
    return Scaffold(
      drawer: SideMenu(),
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
