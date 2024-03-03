import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:polygoniar/components/button.dart';
import 'package:polygoniar/components/inputs.dart';
import 'package:polygoniar/components/screen.dart';
import 'package:polygoniar/main.dart';
import 'package:polygoniar/screens/login/login.dart';
import 'package:polygoniar/utilities/constants.dart';
import 'package:supabase/supabase.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _usernameController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _confirmPasswordController = TextEditingController();
TextEditingController _emailController = TextEditingController();

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
    // Check if sign-up was successful
    
  } catch (AuthException) {
    // Handle other errors, e.g., network issues
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('An error occurred: ${AuthException}'),
      ),
    );
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
        additionalHeight:MediaQuery.of(context).size.height <  826.9 ? MediaQuery.of(context).size.height *0.15 : 0,
        screenTitle: 'New User',
        widgets: [
          MyCustomInput(
            inPutLabelText: 'Your full name',
            inPutHintText: 'E.g John Doe',
            inputCotroller: _usernameController,
          ),
          MyCustomInput(
            inPutLabelText: 'Email',
            inPutHintText: 'E.g johndoe@email.com',
            inputCotroller: _emailController,
          ),
          MyCustomInput(
            inPutLabelText: 'Password',
            inPutHintText: '********',
            inputCotroller: _passwordController,
          ),
          MyCustomInput(
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
