import 'package:crayon_management/responsive.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 14),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 14 / 2,
      ),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/profile.png",
            height: 38,
          ),
          if (!Responsive.isMobile(context))
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12 / 2),
              child: Text("Lionel Schroeder"),
            ),
          Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}
