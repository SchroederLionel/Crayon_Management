import 'package:crayon_management/providers/login_registration_provider/login_provider.dart';
import 'package:crayon_management/utils/authentication.dart';
import 'package:flutter/material.dart';
import 'package:crayon_management/route/route.dart' as route;
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: '');
    _passwordController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var translation = AppLocalizations.of(context);
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    return Center(
        child: SizedBox(
      height: 500,
      width: 400,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              Text(
                'Crayon Management',
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                'assets/images/crayon.png',
                height: 150,
                width: 190,
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextFormField(
                        validator: (val) =>
                            !isEmail(val!) ? translation!.invalidEmail : null,
                        controller: _emailController,
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              size: 18,
                            ),
                            border: UnderlineInputBorder(),
                            labelText: translation!.email),
                      ),
                      TextFormField(
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return translation.required;
                            }
                            if (value.trim().length < 8) {
                              return translation.passwordCheck;
                            }
                            // Return null if the entered password is valid
                            return null;
                          },
                          controller: _passwordController,
                          obscureText: true,
                          style: Theme.of(context).textTheme.bodyText1,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.password,
                                size: 18,
                              ),
                              border: UnderlineInputBorder(),
                              labelText: translation.password)),
                      ElevatedButton.icon(
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14.0, vertical: 14.0)),
                          onPressed: () async {
                            await signInWithEmailPassword(_emailController.text,
                                    _passwordController.text)
                                .then((result) {
                              if (result != null) {
                                print('You are logged In');
                                userProvider.setUserData(result);
                                Navigator.pushNamed(context, route.dashboard);
                              }
                            }).catchError((error) {
                              print('Login Error: $error');
                            });
                          },
                          icon: Icon(Icons.login),
                          label: Text(translation.signIn))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
