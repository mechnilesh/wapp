import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../view/auth/signup_screen.dart';
import '../view/home section/bottom_navbar.dart';

class AuthStateCheck extends StatefulWidget {
  const AuthStateCheck({super.key});

  @override
  State<AuthStateCheck> createState() => _AuthStateCheckState();
}

class _AuthStateCheckState extends State<AuthStateCheck> {
  @override
  void initState() {
    checkAuthState();
    super.initState();
  }

  checkAuthState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        debugPrint("s o");
        Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(
            builder: (ctx) => const LoginScreen(),
          ),
          (route) => false,
        );
      } else {
        debugPrint("s i");
        Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(
            builder: (ctx) => BottomNavBar(),
          ),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
