import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 850;
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 850;
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    // If width is higher or equal to 1100 it is considered as a desktop.
    if (_size.width >= 1100) {
      return desktop;
    }
    // If width is higher or equal to 850 and the tablet which is not null then we will return the tablet layout.
    else if (_size.width >= 850 && tablet != null) {
      return tablet!;
    }
    // Else return mobile layout.
    else {
      return mobile;
    }
  }
}
