import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var translation = AppLocalizations.of(context);
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
          value: 'Lionel Schroeder',
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
                value: 'Lionel Schroeder',
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
