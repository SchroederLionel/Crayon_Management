import 'package:crayon_management/l10n/app_localizations.dart';
import 'package:crayon_management/providers/user/user_header_provider.dart';
import 'package:crayon_management/services/authentication.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appTranslation = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 0,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.blueAccent),
      ),
      child: Consumer<UserHeaderProvider>(
          builder: (context, userHeaderProvider, child) {
        return DropdownButton(
            value: userHeaderProvider.firstNameAndLastName,
            icon: Container(
              margin: const EdgeInsets.only(left: 5),
              child: const Icon(
                Icons.arrow_drop_down,
              ),
            ),
            onChanged: (_) {},
            underline: Container(
              height: 0,
            ),
            items: [
              DropdownMenuItem(
                  onTap: () {},
                  value: userHeaderProvider.firstNameAndLastName,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 30,
                        height: 30,
                        child: Icon(Icons.person),
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        userHeaderProvider.firstNameAndLastName,
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    ],
                  )),
              DropdownMenuItem(
                  value: 'logout',
                  onTap: () {
                    signOut();
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    children: [
                      const SizedBox(
                        child: Icon(
                          Icons.power_off,
                        ),
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        appTranslation!.translate('logout') ?? ' Logout',
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    ],
                  ))
            ]);
      }),
    );
  }
}
