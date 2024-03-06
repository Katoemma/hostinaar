import 'dart:io';

import 'package:Hostinaar/Controller/UserController.dart';
import 'package:Hostinaar/components/button.dart';
import 'package:Hostinaar/main.dart';
import 'package:Hostinaar/screens/profile/CustomWidgets.dart';
import 'package:Hostinaar/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  late Future<String?> _userNameFuture;
  String imageUrl = ''; // Initialize imageUrl with an empty string

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
                          'images/profileSettingBg.png',
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
                                      screenTitle: 'Personal Info',
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
                          Row(
                            children: [
                              imageUrl.isNotEmpty
                                  ? CircleAvatar(
                                      radius: 45,
                                      backgroundImage: imageUrl.isNotEmpty
                                          ? NetworkImage(imageUrl)
                                          : null,
                                    )
                                  : const CircleAvatar(
                                      radius: 45,
                                      backgroundImage:
                                          AssetImage('images/avatar.png'),
                                    ),
                              const SizedBox(
                                width: 80,
                              ),
                              GestureDetector(
                                onTap: () async {
                                //initialise userController class
                                  UserController userController = UserController();
                                //calling fuction to upload avatar
                                  await userController.uploadAvatar(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue[100],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  child: Text(
                                    'Change your photo',
                                    style: TextStyle(color: Colors.blue[900]),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Text('Your name'),
                          const SizedBox(height: 6),
                          TextFormField(
                            readOnly: true,
                            initialValue: userName,
                            decoration: kTextFieldDecoration,
                          ),
                          const SizedBox(height: 6),
                          const Text('Phone number'),
                          const SizedBox(height: 6),
                          TextFormField(
                            initialValue: '+25671234567',
                            decoration: kTextFieldDecoration,
                          ),
                          const SizedBox(height: 6),
                          const Text('Email'),
                          const SizedBox(height: 6),
                          TextFormField(
                            initialValue: 'johndoe@gmail.com',
                            decoration: kTextFieldDecoration,
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
