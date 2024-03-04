import 'dart:convert';

import 'package:Hostinaar/components/button.dart';
import 'package:Hostinaar/components/inputs.dart';
import 'package:Hostinaar/components/screen.dart';
import 'package:Hostinaar/main.dart';
import 'package:Hostinaar/screens/dashboard/dashboard.dart';
import 'package:Hostinaar/screens/signUp/signUpScreen.dart';
import 'package:Hostinaar/utilities/constants.dart';
import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        //show loading
        showDialog(
          context: context,
          builder: (context) => Center(
              child:
                  LoadingAnimationWidget.beat(color: Colors.orange, size: 35)),
        );
        AuthResponse res = await supabase.auth.signInWithPassword(
          email: email,
          password: password,
        );

        var userDetailsFromDb =
            await supabase.from('users').select().eq('email', email);

        SharedPreferences pref = await SharedPreferences.getInstance();
        print(userDetailsFromDb[0]['userType']);

        await pref.setString('userName', userDetailsFromDb[0]['userName']);
        //redirect to dashboard screen
        if (userDetailsFromDb[0]['userType'] == 'ST') {
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const DashboardScreen(),
            ),
          );
        } else {
          //alert 'To use web'
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text('Not A Student'),
                    content: const Text(
                        'You can only login on the web version of this application'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ));
          await supabase.auth.signOut();
          //Navigator.pop(context); // Close the dialog

          //close loading dialog
          Future.delayed(
            const Duration(seconds: 4),
            () async {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          );
        }
        // Close the dialog
      } catch (e) {
        if (e is AuthException) {
          //show snackBar
          Navigator.pop(context); // Close the dialog
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(e.message),
            ),
          );
        } else {
          Navigator.pop(context); // Close the dialog
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red[500],
              content: Row(
                children: [
                  const Icon(Icons.warning),
                  Text(
                    '$e',
                    style: const TextStyle(fontSize: 18),
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
