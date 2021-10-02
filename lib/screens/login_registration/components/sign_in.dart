import 'package:flutter/material.dart';
import 'package:crayon_management/route/route.dart' as route;

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      height: 350,
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
                height: 14,
              ),
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
              const SizedBox(
                height: 14,
              ),
              TextFormField(
                  obscureText: true,
                  style: Theme.of(context).textTheme.bodyText1,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.password,
                        size: 18,
                      ),
                      border: UnderlineInputBorder(),
                      labelText: 'Password')),
              const Spacer(),
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
    ));
  }
}
