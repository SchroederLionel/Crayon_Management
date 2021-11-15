import 'package:crayon_management/datamodels/failure.dart';
import 'package:crayon_management/l10n/app_localizations.dart';
import 'package:crayon_management/services/authentication.dart';
import 'package:crayon_management/services/validator_service.dart';
import 'package:crayon_management/widgets/cancel_button.dart';
import 'package:crayon_management/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class ResetPasswordDailog extends StatefulWidget {
  const ResetPasswordDailog({Key? key}) : super(key: key);

  @override
  _ResetPasswordDailogState createState() => _ResetPasswordDailogState();
}

class _ResetPasswordDailogState extends State<ResetPasswordDailog> {
  late TextEditingController _emailController;
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    var appTranslation = AppLocalizations.of(context);
    return AlertDialog(
        title: Text(
          appTranslation!.translate('reset-password') ?? 'Reset password',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        actions: [
          const CancelButton(),
          ElevatedButton(
            onPressed: () async {
              if (_emailController.text.isNotEmpty) {
                try {
                  await resetPassword(_emailController.text);
                  Navigator.pop(context, true);
                } on Failure catch (e) {
                  Navigator.pop(context, e);
                }
              }
            },
            child: Text(
                appTranslation.translate('send-request') ?? 'Send request'),
          )
        ],
        content: SizedBox(
          height: 90,
          child: Column(
            children: [
              CustomTextFormField(
                controller: _emailController,
                icon: Icons.email,
                isPassword: false,
                labelText: appTranslation.translate('email') ?? 'Email',
                validator: (String? text) =>
                    ValidatorService.checkEmail(text, appTranslation),
                onChanged: (text) {},
              ),
            ],
          ),
        ));
  }
}
