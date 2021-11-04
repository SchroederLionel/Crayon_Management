import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrDialog extends StatelessWidget {
  final String lectureId;
  const QrDialog({required this.lectureId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 600,
        width: 600,
        alignment: Alignment.center,
        child: QrImage(
          foregroundColor: Colors.white,
          data: lectureId,
          version: QrVersions.auto,
          size: 500.0,
        ),
      ),
    );
  }
}
