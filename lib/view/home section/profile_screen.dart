import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_model/auth_view_model.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  // curretn user
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(child: Icon(Icons.person)),
          Column(
            children: [
              Text(
                "Email:",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                user!.email.toString(),
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text(
              "Sign Out From Firebase",
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              context.read<AuthViewModel>().signOut(context: context);
            },
          ),
        ],
      ),
    );
  }
}
