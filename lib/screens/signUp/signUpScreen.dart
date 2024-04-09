import 'package:Hostinaar/Components/button.dart';
import 'package:Hostinaar/Components/inputs.dart';
import 'package:Hostinaar/Components/screen.dart';
import 'package:Hostinaar/screens/login/login.dart';
import 'package:Hostinaar/helpers/constants.dart';
import 'package:flutter/material.dart';

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
            onPressed: () async {
              String username = _usernameController.text.trim();
              String password = _passwordController.text.trim();
              String confirmPassword = _confirmPasswordController.text.trim();
              String email = _emailController.text.trim();

            //sign Up User
              await userController.signUpUser(
                context,
                username,
                password,
                confirmPassword,
                email,
              );
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
