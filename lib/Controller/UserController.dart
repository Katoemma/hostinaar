import 'dart:io';

import 'package:Hostinaar/helpers/PrefsBrain.dart';
import 'package:Hostinaar/helpers/userProfilePic.dart';
import 'package:Hostinaar/main.dart';
import 'package:Hostinaar/screens/dashboard/dashboard.dart';
import 'package:Hostinaar/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserController {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
//initialise sharedPrefsHelper
  SharedPrefsHelper sharedPrefsHelper = SharedPrefsHelper();

//function to log out user
  Future<void> logoutUser(context) async {
    supabase.auth.signOut();
    // Clear user data from SharedPreferences if needed.
    await SharedPrefsHelper.remove('userName');
    await SharedPrefsHelper.remove('profilePic');
    DefaultCacheManager().emptyCache(); // Clear image cache
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  //function to sign up user
  Future<void> signUpUser(BuildContext context, username, password,confirmPassword,email) async {


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

  //function to login user
  Future<void> loginUser(context, String email, String password) async {
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

        //save user details to shared preferences
        await SharedPrefsHelper.saveString(
            'userName', userDetailsFromDb[0]['userName']);
        if(userDetailsFromDb[0]['profilePic'] != null){
          ProfilePicHelper profilePicHelper = ProfilePicHelper();
          //download image to cache
          File profilePic = await profilePicHelper.downloadImage(userDetailsFromDb[0]['profilePic']);
          //save the file path to sharedPreference
          await SharedPrefsHelper.saveString('profilePic', profilePic.path);
        }

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
            ),
          );
          //call the logoutUser method
          await supabase.auth.signOut();

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

//function to upload avatar
  Future<void> uploadAvatar(BuildContext context, image) async {
    try {
      //initialise profilePic helper
      ProfilePicHelper profilePicHelper = ProfilePicHelper();

      // check if an image has been selected
      if (image != null) {
        final bytes = await image.readAsBytes();
        final fileExt = image.path.split('.').last;
        final fileName = '${DateTime.now().toIso8601String()}.$fileExt';
        final filePath = fileName;
        final response = await supabase.storage.from('avatars').uploadBinary(
            filePath, bytes,
            fileOptions: FileOptions(contentType: image.mimeType));

        if (response != null) {
          // get the public URL from Supabase
          final String publicUrl =
              supabase.storage.from('avatars').getPublicUrl(filePath);

          //Download the image to cache manager
          File localImage = await profilePicHelper.downloadImage(publicUrl);

          // save the public URL to shared preferences and update the database with the new URL
          await SharedPrefsHelper.saveString('profilePic', localImage.path);

          final updatePic = await supabase
              .from('users')
              .update({'profilePic': publicUrl}).eq(
                  'email', supabase.auth.currentUser!.email.toString());

          // if (updatePic != null && updatePic.error != null) {
          scaffoldMessengerKey.currentState?.showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text('Profile photo updated successfully'),
            ),
          );
        }
      }
    } catch (e) {
      print(e.toString());
      scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Error occurred: $e'),
        ),
      );
    }
  }
}
