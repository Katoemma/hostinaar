import 'package:Hostinaar/main.dart';
import 'package:Hostinaar/screens/login/login.dart';
import 'package:Hostinaar/screens/profile/profileScren.dart';
import 'package:Hostinaar/utilities/constants.dart';
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

  void getUserName() async {
    SharedPreferences prefs = await SharedPreferences
        .getInstance(); // Get the SharedPreferences instance.
    setState(() {
      // Update the state to trigger a rebuild.
      username = prefs.getString('userName') ??
          ''; // Retrieve the username from SharedPreferences. If it's null, use an empty string.
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getUserName();
  }

  @override
  Widget build(BuildContext context) {
    // Replace these with actual user details
    late String profilePicture =
        'https://ntrepidcorp.com/wp-content/uploads/2016/06/team-1.jpg';
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
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              foregroundImage:
                  profilePicture == null ? null : NetworkImage(profilePicture),
            ),
            decoration: const BoxDecoration(
              color: kPrimaryColor,
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
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await supabase.auth.signOut();

              await prefs.remove('userName');

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
