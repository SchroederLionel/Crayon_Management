import 'package:crayon_management/providers/login_registration_provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:crayon_management/route/route.dart' as route;
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

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
    final LoginProvider loginProvider =
        Provider.of<LoginProvider>(context, listen: false);
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
                            !isEmail(val!) ? "Invalid Email" : null,
                        controller: _emailController,
                        onChanged: (String text) =>
                            loginProvider.setEmail(text),
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              size: 18,
                            ),
                            border: UnderlineInputBorder(),
                            labelText: 'Email'),
                      ),
                      TextFormField(
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'This field is required';
                            }
                            if (value.trim().length < 8) {
                              return 'Password must be at least 8 characters in length';
                            }
                            // Return null if the entered password is valid
                            return null;
                          },
                          controller: _passwordController,
                          onChanged: (String text) =>
                              loginProvider.setPassword(text),
                          obscureText: true,
                          style: Theme.of(context).textTheme.bodyText1,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.password,
                                size: 18,
                              ),
                              border: UnderlineInputBorder(),
                              labelText: 'Password')),
                      ElevatedButton.icon(
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14.0, vertical: 14.0)),
                          onPressed: () {
                            Navigator.pushNamed(context, route.dashboard);
                          },
                          icon: Icon(Icons.login),
                          label: Text('Sign in'))
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
