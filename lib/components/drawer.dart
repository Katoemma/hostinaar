import 'package:Hostinaar/Controller/UserController.dart';
import 'package:Hostinaar/screens/profile/profileScren.dart';
import 'package:Hostinaar/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    super.key,
    this.email,
  });

  final email;

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  var username = '';
  String imageUrl = '';

  void getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences
        .getInstance(); // Get the SharedPreferences instance.
    setState(() {
      // Update the state to trigger a rebuild.
      username = prefs.getString('userName') ?? '';
      imageUrl = prefs.getString('profilePic') ??
          ''; // Retrieve the username from SharedPreferences. If it's null, use an empty string.
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    // Replace these with actual user details
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              username,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              '${widget.email}',
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            currentAccountPicture: imageUrl.isNotEmpty
                ? CircleAvatar(
                    backgroundColor: Colors.white,
                    foregroundImage: NetworkImage(imageUrl),
                  )
                : const CircleAvatar(
                    backgroundColor: Colors.white,
                    foregroundImage: AssetImage('images/avatar.png'),
                  ),
            decoration: const BoxDecoration(
              color: kAdditionalColor,
            ),
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.home),
                Text('Home'),
              ],
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.event),
                Text('Bookings'),
              ],
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.person),
                Text('Profile'),
              ],
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()));
            },
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.info),
                Text('About'),
              ],
            ),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            title: Row(
              children: [
                Icon(
                  Icons.logout,
                  color: Colors.red[200],
                ),
                Text('Logout', style: TextStyle(color: Colors.red[200])),
              ],
            ),
            onTap: () async {
              //initilise userController
              UserController userController = UserController();
              //call the logout function
              userController.logoutUser(context);
            },
          ),
        ],
      ),
    );
  }
}
