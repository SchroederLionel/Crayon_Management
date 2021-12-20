import 'package:flutter/material.dart';

class StepContent extends StatelessWidget {
  final Widget widget;
  const StepContent({Key? key, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: widget,
    );
  }
}
