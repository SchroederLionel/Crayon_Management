import 'package:crayon_management/providers/menu_provider.dart';
import 'package:crayon_management/screens/dashboard/components/header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardMainScreen extends StatelessWidget {
  const DashboardMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      padding: EdgeInsets.all(14),
      child: Column(
        children: [
          Header(),
          const SizedBox(
            height: 14.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [],
          )
        ],
      ),
    ));
  }
}
