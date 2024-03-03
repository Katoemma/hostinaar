import 'package:Hostinaar/components/button.dart';
import 'package:Hostinaar/components/inputs.dart';
import 'package:Hostinaar/components/screen.dart';
import 'package:Hostinaar/main.dart';
import 'package:Hostinaar/screens/dashboard/dashboard.dart';
import 'package:Hostinaar/screens/signUp/signUpScreen.dart';
import 'package:Hostinaar/utilities/constants.dart';
import 'package:flutter/material.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //login functionality
  void login() async {
    //validate inputs
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Please fill all fields'),
        ),
      );
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-z]{2,}$')
        .hasMatch(email)) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Please enter a valid email'),
        ),
      );
    } else {
      try {
        AuthResponse res = await supabase.auth.signInWithPassword(
          email: email,
          password: password,
        );
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => DashboardScreen(
                    user: res.user)) //navigate to home screen with user data
            );
      } catch (e) {
        if (e is AuthException) {
          //show snackBar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red[500],
              content: const Row(
                children: [
                  Icon(Icons.warning),
                  Text(
                    'Check Your internet connection',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyCustomScreen(
        additionalHeight: 0,
        screenTitle: 'Login',
        widgets: [
          MyCustomInput(
            isPassword: false,
            inPutLabelText: 'Email',
            inPutHintText: 'your email',
            inputCotroller: _emailController,
          ),
          MyCustomInput(
            isPassword: true,
            inPutLabelText: 'Password',
            inPutHintText: '*********',
            inputCotroller: _passwordController,
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
              onTap: () {},
              child: const Text(
                'Forgot Password?',
                style: TextStyle(color: kPrimaryColor),
              )),
          const SizedBox(
            height: 10,
          ),
          MyButton(
            onPressed: () {
              login();
            },
            btnText: 'Sign in',
            btnColour: kPrimaryColor,
          ),
          Row(
            children: [
              const Text("Don't have an account?"),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Sign up',
                  style: TextStyle(
                      color: kPrimaryColor, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
