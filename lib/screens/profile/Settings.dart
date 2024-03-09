import 'package:Hostinaar/Components/inputs.dart';
import 'package:Hostinaar/Controller/UserController.dart';
import 'package:Hostinaar/Components/button.dart';
import 'package:Hostinaar/screens/profile/CustomWidgets.dart';
import 'package:Hostinaar/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late Future<String?> _userNameFuture;
  String imageUrl = ''; // Initialize imageUrl with an empty string

  TextEditingController myNewPassword = TextEditingController();
  TextEditingController myConfirmPassword = TextEditingController();
  TextEditingController myOldPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userNameFuture = getUserDetails();
    // Fetch imageUrl here as well, if needed
    fetchImageUrl();
  }

  Future<String?> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName') ?? '';
  }

  void fetchImageUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      imageUrl = prefs.getString('profilePic') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<String?>(
        future: _userNameFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          String userName = snapshot.data ?? '';

          return SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(
                      children: [
                        Image.asset(
                          'images/myBg1.png',
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                        const Column(
                          children: [
                            SafeArea(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  children: [
                                    HeaderWidget(
                                      screenTitle: 'Settings',
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text('Your name'),
                          const SizedBox(height: 6),
                          TextFormField(
                            readOnly: true,
                            initialValue: userName,
                            decoration: kTextFieldDecoration,
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Change your password',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          MyCustomInput(
                            inPutLabelText: '',
                            inPutHintText: 'Your current password',
                            inputCotroller: myOldPassword,
                            isPassword: true,
                          ),
                          MyCustomInput(
                            inPutLabelText: '',
                            inPutHintText: 'Your new password',
                            inputCotroller: myOldPassword,
                            isPassword: true,
                          ),
                          MyCustomInput(
                            inPutLabelText: '',
                            inPutHintText: 'Retype your new Password',
                            inputCotroller: myOldPassword,
                            isPassword: true,
                          ),
                          
                          const SizedBox(height: 16),
                          MyButton(
                              onPressed: () {},
                              btnText: 'Save',
                              btnColour: kPrimaryColor)
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
