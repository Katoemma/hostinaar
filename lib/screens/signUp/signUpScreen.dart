import 'package:Hostinaar/components/button.dart';
import 'package:Hostinaar/components/inputs.dart';
import 'package:Hostinaar/components/screen.dart';
import 'package:Hostinaar/main.dart';
import 'package:Hostinaar/screens/dashboard/dashboard.dart';
import 'package:Hostinaar/screens/login/login.dart';
import 'package:Hostinaar/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:supabase/supabase.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  void signUp(BuildContext context) async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();
    String email = _emailController.text.trim();

    if (username.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
        ),
      );
      return;
    } else if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
        ),
      );
      return;
    } else if (!isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email address'),
        ),
      );
      return;
    }

    try {
      final AuthResponse response =
          await supabase.auth.signUp(email: email, password: password);
      final userDetails = await supabase.from('users').insert(
          {'userName': username, 'email': email, 'userType': 'ST'}).select();
      print(userDetails);

      if (userDetails.isNotEmpty) {
        SharedPreferences pref = await SharedPreferences.getInstance();

        await pref.setString('userName', userDetails[0]['userName']);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const DashboardScreen(),
          ),
        );
      }
      // add user details to user preference
    } catch (e) {
      // Handle other errors, e.g., network issues
      if (e is AuthException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error occured $e'),
          ),
        );
      }
    }
  }

  bool isValidEmail(String email) {
    // Regular expression for validating email format
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyCustomScreen(
        additionalHeight: MediaQuery.of(context).size.height < 826.9
            ? MediaQuery.of(context).size.height * 0.15
            : 0,
        screenTitle: 'New User',
        widgets: [
          MyCustomInput(
            isPassword: false,
            inPutLabelText: 'Your full name',
            inPutHintText: 'E.g John Doe',
            inputCotroller: _usernameController,
          ),
          MyCustomInput(
            isPassword: false,
            inPutLabelText: 'Email',
            inPutHintText: 'E.g johndoe@email.com',
            inputCotroller: _emailController,
          ),
          MyCustomInput(
            isPassword: true,
            inPutLabelText: 'Password',
            inPutHintText: '********',
            inputCotroller: _passwordController,
          ),
          MyCustomInput(
            isPassword: true,
            inPutLabelText: 'Confirm Password',
            inPutHintText: '********',
            inputCotroller: _confirmPasswordController,
          ),
          const SizedBox(height: 12),
          MyButton(
            onPressed: () {
              signUp(context);
            },
            btnText: 'Sign up',
            btnColour: kPrimaryColor,
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              const Text('Already have an account?'),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Sign in',
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
