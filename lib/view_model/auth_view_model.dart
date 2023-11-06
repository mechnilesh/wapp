import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:wapp/utils/utils.dart';

import '../view/screens/weather_screen.dart';

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
              builder: (context) => const WeatherScreen(),
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
}
