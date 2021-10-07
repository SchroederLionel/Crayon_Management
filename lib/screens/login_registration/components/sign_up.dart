import 'package:crayon_management/providers/login_registration_provider/registration_provider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

class SignUp extends StatefulWidget {
  final GlobalKey<FlipCardState> cardKey;
  const SignUp({required this.cardKey, Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late TextEditingController _emailController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _passwordController;
  late TextEditingController _verificationPasswordController;
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: '');
    _firstNameController = TextEditingController(text: '');
    _lastNameController = TextEditingController(text: '');
    _passwordController = TextEditingController(text: '');
    _verificationPasswordController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passwordController.dispose();
    _verificationPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final RegistrationProvider registrationProvider =
        Provider.of<RegistrationProvider>(context, listen: false);
    return Center(
        child: SizedBox(
      height: 530,
      width: 400,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Registration',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  IconButton(
                      onPressed: () =>
                          widget.cardKey.currentState!.toggleCard(),
                      icon: const Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 24,
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextFormField(
                        validator: (val) =>
                            !isEmail(val!) ? "Invalid Email" : null,
                        controller: _emailController,
                        onChanged: (String text) =>
                            registrationProvider.setEmail(text),
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
                        validator: (val) => !isByteLength(val!, 2)
                            ? "First Name cannot be empty"
                            : null,
                        onChanged: (String text) =>
                            registrationProvider.setFirstName(text),
                        controller: _firstNameController,
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              size: 18,
                            ),
                            border: UnderlineInputBorder(),
                            labelText: 'Firstname'),
                      ),
                      TextFormField(
                        validator: (val) => !isByteLength(val!, 2)
                            ? "Last Name cannot be empty"
                            : null,
                        onChanged: (String text) =>
                            registrationProvider.setLastName(text),
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              size: 18,
                            ),
                            border: UnderlineInputBorder(),
                            labelText: 'Lastname'),
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
                          onChanged: (String text) =>
                              registrationProvider.setPassword(text),
                          style: Theme.of(context).textTheme.bodyText1,
                          obscureText: true,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.password,
                                size: 18,
                              ),
                              border: UnderlineInputBorder(),
                              labelText: 'Password')),
                      TextFormField(
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'This field is required';
                            }
                            if (value.trim().length < 8) {
                              return 'Password must be at least 8 characters in length';
                            }

                            if (value == _passwordController.text) {
                              return 'Passwords do not match.';
                            }

                            return null;
                          },
                          onChanged: (String text) => registrationProvider
                              .setVerificationPassword(text),
                          style: Theme.of(context).textTheme.bodyText1,
                          obscureText: true,
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
                          onPressed: () {},
                          icon: Icon(Icons.login),
                          label: Text('Register'))
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

class RegistrationFields extends StatelessWidget {
  const RegistrationFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextFormField(
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
          style: Theme.of(context).textTheme.bodyText1,
          decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                size: 18,
              ),
              border: UnderlineInputBorder(),
              labelText: 'Firstname'),
        ),
        TextFormField(
          style: Theme.of(context).textTheme.bodyText1,
          decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                size: 18,
              ),
              border: UnderlineInputBorder(),
              labelText: 'Lastname'),
        ),
        TextFormField(
            style: Theme.of(context).textTheme.bodyText1,
            obscureText: true,
            decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.password,
                  size: 18,
                ),
                border: UnderlineInputBorder(),
                labelText: 'Password')),
        TextFormField(
            style: Theme.of(context).textTheme.bodyText1,
            obscureText: true,
            decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.password,
                  size: 18,
                ),
                border: UnderlineInputBorder(),
                labelText: 'Password')),
      ],
    );
  }
}
