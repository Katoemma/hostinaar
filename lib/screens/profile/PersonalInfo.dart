import 'dart:io';

import 'package:Hostinaar/main.dart';
import 'package:Hostinaar/screens/profile/CustomWidgets.dart';
import 'package:Hostinaar/utilities/constants.dart';
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

  @override
  void initState() {
    super.initState();
    _userNameFuture = getUserDetails();
  }

  Future<String?> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName') ?? '';
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 45,
                                backgroundImage: NetworkImage(
                                    'https://ntrepidcorp.com/wp-content/uploads/2016/06/team-1.jpg'),
                              ),
                              const SizedBox(
                                width: 80,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  try {
                                    //initialise image picker package
                                    final ImagePicker picker = ImagePicker();

                                    //call the picker to select photo from gallery
                                    final image = await picker.pickImage(
                                        source: ImageSource.gallery);

                                    //check if the image has been selected
                                    if (image != null) {
                                      final bytes = await image.readAsBytes();
                                      final fileExt =
                                          image.path.split('.').last;
                                      final fileName =
                                          '${DateTime.now().toIso8601String()}.$fileExt';
                                      final filePath = fileName;
                                      final response = await supabase.storage
                                          .from('avatars')
                                          .uploadBinary(
                                            filePath,
                                            bytes,
                                            fileOptions: FileOptions(
                                                contentType: image.mimeType),
                                          );

                                      if (response != null) {
                                        //show nack bar
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            backgroundColor: Colors.green,
                                            content: Text(
                                                'Profile Picture Uploaded'),
                                          ),
                                        );
                                      }
                                    }
                                  } catch (e) {
                                    print(e.toString());
                                  }
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
                              decoration: kTextFieldDecoration),
                          const SizedBox(height: 6),
                          const Text('Phone number'),
                          const SizedBox(height: 6),
                          TextFormField(
                              initialValue: '+25671234567',
                              decoration: kTextFieldDecoration),
                          const SizedBox(height: 6),
                          const Text('Email'),
                          const SizedBox(height: 6),
                          TextFormField(
                              initialValue: 'johndoe@gmail.com',
                              decoration: kTextFieldDecoration)
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
