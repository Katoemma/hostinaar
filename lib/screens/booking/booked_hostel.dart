import 'dart:io';

import 'package:Hostinaar/Controller/UserController.dart';
import 'package:Hostinaar/components/button.dart';
import 'package:Hostinaar/helpers/constants.dart';
import 'package:Hostinaar/screens/profile/CustomWidgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BookedRoomScreen extends StatefulWidget {
  const BookedRoomScreen({super.key});

  @override
  State<BookedRoomScreen> createState() => _BookedRoomScreenState();
}

class _BookedRoomScreenState extends State<BookedRoomScreen> {
  @override
  Widget build(BuildContext context) {
    var imageUrl='https://pyxis.nymag.com/v1/imgs/51b/28a/622789406b8850203e2637d657d5a0e0c3-avatar-rerelease.2x.rsocial.w600.jpg';
    return Scaffold(
      body: SingleChildScrollView(
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
                                          ? FileImage(File(imageUrl))
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
                                  // Open showModalBottomSheet
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        height: 150, // Adjust height as needed
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            ListTile(
                                              leading: const Icon(Icons.photo_camera),
                                              title: const Text('Camera'),
                                              onTap: () async {
                                                //initialise user controller
                                                UserController userController =
                                                    UserController();
                                                final ImagePicker picker =
                                                    ImagePicker();

                                                // call the picker to select a photo from the gallery
                                                final image =
                                                    await picker.pickImage(
                                                        source:
                                                            ImageSource.camera);

                                                            showDialog(context: context, builder: (context) => Center(
                                                  child: Column(children: [
                                                    LoadingAnimationWidget.fourRotatingDots(color: Colors.blue, size: 50),
                                                    const Text('Uploading...', style: TextStyle(fontSize: 20),),
                                                  ],),
                                                ));
                                                await userController
                                                    .uploadAvatar(
                                                        context, image);
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            ListTile(
                                              leading: const Icon(Icons.photo),
                                              title: const Text('Gallery'),
                                              onTap: () async {
                                                UserController userController =
                                                    UserController();
                                                final ImagePicker picker =
                                                    ImagePicker();

                                                // call the picker to select a photo from the gallery
                                                final image =
                                                    await picker.pickImage(
                                                        source: ImageSource
                                                            .gallery);
                                                //show loading dialog
                                                showDialog(context: context, builder: (context) => Center(
                                                  child: Column(children: [
                                                    LoadingAnimationWidget.fourRotatingDots(color: Colors.blue, size: 50),
                                                    const Text('Uploading...', style: TextStyle(fontSize: 20),),
                                                  ],),
                                                ));
                                                await userController
                                                    .uploadAvatar(
                                                        context, image);
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFB000),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  child: const Text(
                                    'Change your photo',
                                    style: TextStyle(color: Colors.white),
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
                            initialValue: 'Emmy kayo',
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
          ),);

}

}