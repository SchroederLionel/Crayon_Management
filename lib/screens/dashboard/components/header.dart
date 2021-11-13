import 'package:crayon_management/datamodels/enum.dart';
import 'package:crayon_management/l10n/app_localizations.dart';
import 'package:crayon_management/providers/user/user_header_provider.dart';
import 'package:crayon_management/providers/user/user_provider.dart';
import 'package:crayon_management/providers/util_providers/menu_provider.dart';
import 'package:crayon_management/responsive.dart';
import 'package:crayon_management/screens/dashboard/components/profile_card.dart';
import 'package:crayon_management/widgets/error_text.dart';
import 'package:crayon_management/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appLocalization = AppLocalizations.of(context);
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: context.read<MenuProvider>().controlMenu,
          ),
        if (!Responsive.isMobile(context))
          Text(
            appLocalization!.translate('dashboard') ?? 'Dashboard',
            style: Theme.of(context).textTheme.headline1,
          ),
        Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Consumer<UserProvider>(builder: (_, userProvider, __) {
          if (userProvider.state == NotifierState.initial) {
            return Container();
          } else if (userProvider.state == NotifierState.loading) {
            return const LoadingWidget();
          } else {
            return userProvider.user.fold(
                (failure) => ErrorText(
                      error: failure.code,
                    ), (userData) {
              WidgetsBinding.instance!.addPostFrameCallback((_) =>
                  Provider.of<UserHeaderProvider>(context, listen: false)
                      .setFirstName(userData.firstNameAndLastName));

              return const ProfileCard();
            });
          }
        })
      ],
    );
  }
}
