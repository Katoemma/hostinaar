import 'package:Hostinaar/Controller/UserController.dart';
import 'package:Hostinaar/components/button.dart';
import 'package:Hostinaar/components/inputs.dart';
import 'package:Hostinaar/components/screen.dart';
import 'package:Hostinaar/screens/signUp/signUpScreen.dart';
import 'package:Hostinaar/helpers/constants.dart';
import 'package:flutter/material.dart';

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
    //initialise UserCotroller
    UserController userController = UserController();

    //organising the input values
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    userController.loginUser(context, email, password);
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
