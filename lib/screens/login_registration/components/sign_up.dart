import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      height: 460,
      width: 400,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              Text(
                'Registration',
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(
                height: 14,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    border: UnderlineInputBorder(),
                    labelText: 'Email'),
              ),
              const SizedBox(
                height: 14,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    border: UnderlineInputBorder(),
                    labelText: 'Firstname'),
              ),
              const SizedBox(
                height: 14,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    border: UnderlineInputBorder(),
                    labelText: 'Lastname'),
              ),
              const SizedBox(
                height: 14,
              ),
              TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.password),
                      border: UnderlineInputBorder(),
                      labelText: 'Password')),
              const SizedBox(
                height: 14,
              ),
              TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.password),
                      border: UnderlineInputBorder(),
                      labelText: 'Password')),
              const Spacer(),
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
    ));
  }
}
