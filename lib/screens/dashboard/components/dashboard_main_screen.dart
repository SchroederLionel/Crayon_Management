import 'package:crayon_management/responsive.dart';
import 'package:crayon_management/screens/dashboard/components/header.dart';
import 'package:crayon_management/screens/dashboard/components/lectures.dart';
import 'package:flutter/material.dart';

class DashboardMainScreen extends StatelessWidget {
  const DashboardMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return SafeArea(
        child: SingleChildScrollView(
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          const Header(),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    const Lectures(),
                    const SizedBox(
                      height: 10,
                    ),
                    Responsive(
                        mobile: LectureInfoCardGridView(
                          crossAxisCount: _size.width < 650 ? 1 : 2,
                        ),
                        tablet: LectureInfoCardGridView(
                          crossAxisCount: 3,
                        ),
                        desktop: LectureInfoCardGridView(
                          crossAxisCount: 4,
                        )),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}
