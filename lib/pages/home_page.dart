import 'package:flutter/material.dart';

import '../controllers/phone_auth_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Home Page"),
      ),
      body: Center(
        child: FilledButton.icon(
          onPressed: () => PhoneAuthController.logout(context),
          label: Text("Logout"),
          icon: Icon(Icons.logout),
          style: FilledButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        ),
      ),
    );
  }
}
