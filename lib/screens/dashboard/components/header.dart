import 'package:crayon_management/providers/menu_provider.dart';
import 'package:crayon_management/responsive.dart';
import 'package:crayon_management/screens/dashboard/components/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: context.read<MenuProvider>().controlMenu,
          ),
        if (!Responsive.isMobile(context))
          Text(
            "Dashboard",
            style: Theme.of(context).textTheme.headline1,
          ),
        Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        const ProfileCard()
      ],
    );
  }
}
