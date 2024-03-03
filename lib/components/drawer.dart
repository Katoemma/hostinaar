import 'package:Hostinaar/main.dart';
import 'package:Hostinaar/screens/login/login.dart';
import 'package:Hostinaar/utilities/constants.dart';
import 'package:flutter/material.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Replace these with actual user details
    late String profilePicture =
        'https://sm.ign.com/ign_nordic/cover/a/avatar-gen/avatar-generations_prsz.jpg';

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: const Text(
              'John doe',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: const Text(
              'johndoe@email.com',
              style: TextStyle(
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
            onTap: () {},
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.settings),
                Text('Settings'),
              ],
            ),
            onTap: () {},
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
            onTap: () {
              supabase.auth.signOut();
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
