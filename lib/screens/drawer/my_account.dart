import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resumex/models/models.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({super.key});
  static const routeName = '/my-account';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Name: ${user.name}'),
            Text('Email: ${user.email}'),
            Text('Phone Number: ${user.phoneNumber}'),
            // Text('Phone Number: ${user.}'),
          ],
        ),
      ),
    );
  }
}
