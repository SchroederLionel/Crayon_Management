import 'package:crayon_management/providers/login_registration_provider/user_provider.dart';
import 'package:crayon_management/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var translation = AppLocalizations.of(context);
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 0,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.blueAccent),
      ),
      child: DropdownButton(
          value: userProvider.getFirstAndLastName,
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
                value: userProvider.getFirstAndLastName,
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      child: Image.asset(
                        "assets/images/profile.png",
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    Text(
                      "Lionel Schroeder",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                )),
            DropdownMenuItem(
                value: 'logout',
                onTap: () {
                  signOut();
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Container(
                      child: Icon(
                        Icons.power_off,
                      ),
                      width: 40,
                      height: 40,
                    ),
                    SizedBox(width: 5.0),
                    Text(
                      translation!.logout,
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                ))
          ]),
    );
  }
}
