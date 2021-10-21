import 'package:crayon_management/datamodels/confirmation_dialog_data.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final ConfirmationDialogData confirmationDialogData;
  const ConfirmationDialog({required this.confirmationDialogData, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        confirmationDialogData.title,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            confirmationDialogData.description,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Center(
            child: Text(
              confirmationDialogData.itemTitle,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.black26)),
            onPressed: () => Navigator.pop(context, false),
            child: Text(confirmationDialogData.cancelTitle)),
        ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(confirmationDialogData.acceptTitle))
      ],
    );
  }
}
