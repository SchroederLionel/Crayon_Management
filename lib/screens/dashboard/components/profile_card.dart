import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 0,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: DropdownButton(
          value: 'Lionel Schroeder',
          icon: Container(
            margin: const EdgeInsets.only(left: 5),
            child: const Icon(
              Icons.arrow_downward,
              color: Colors.white54,
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
                      width: 40,
                      height: 40,
                      child: Image.asset(
                        "assets/images/profile.png",
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    const Text("Lionel Schroeder"),
                  ],
                )),
            DropdownMenuItem(
                value: 'logout',
                onTap: () {},
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
                    Text('Logout')
                  ],
                ))
          ]),
    );
  }
}
