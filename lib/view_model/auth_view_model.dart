import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:wapp/utils/utils.dart';
import 'package:wapp/view/auth/signup_screen.dart';
import 'package:wapp/view/home%20section/bottom_navbar.dart';

import '../view/home section/home_screen.dart';

class AuthViewModel with ChangeNotifier {
  bool isLoding = false;

  // sign up with email and password
  void signupEmaiIdToFireBase({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    isLoding = true;
    notifyListeners();
    try {
      // UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(
              builder: (context) => BottomNavBar(),
            ),
            (Route<dynamic> route) => false);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print("weak-password");
        UtilsForUser(context).snowSnackBar("weak-password");
        if (!context.mounted) return;
      } else if (e.code == 'email-already-in-use') {
        if (!context.mounted) return;
        print("email-already-in-use");
        UtilsForUser(context).snowSnackBar("email-already-in-use");
      }
      isLoding = false;
      notifyListeners();
    } catch (e) {
      UtilsForUser(context).snowSnackBar("$e");
      isLoding = false;
      notifyListeners();
      if (!context.mounted) return;
    }
  }

  // sign out
  void signOut({required BuildContext context}) async {
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
          CupertinoPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (Route<dynamic> route) => false);
    }
  }
}
