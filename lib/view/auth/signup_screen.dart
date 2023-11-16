import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wapp/view_model/auth_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 56, 56, 56),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "Sign-Up Here",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            Column(
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            context.watch<AuthViewModel>().isLoding
                ? const CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: CircularProgressIndicator(),
                  )
                : ElevatedButton(
                    onPressed: () {
                      context.read<AuthViewModel>().signupEmaiIdToFireBase(
                            context: context,
                            email: emailController.value.text,
                            password: passwordController.value.text,
                          );
                    },
                    child: const Text("Login"),
                  ),
          ],
        ),
      ),
    );
  }
}
