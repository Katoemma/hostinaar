import 'package:Hostinaar/main.dart';
import 'package:Hostinaar/screens/login/login.dart';
import 'package:Hostinaar/screens/profile/CustomWidgets.dart';
import 'package:Hostinaar/screens/profile/PersonalInfo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = '';

  void GetUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(
      (){
        userName = prefs.getString('userName') ?? '';
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetUserDetails(); // Call the function to get the user details from SharedPreferences.
  }

  @override
  Widget build(BuildContext context) {
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
                      'images/profileBg.png',
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                     Column(
                      children: [
                        SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: [
                                const HeaderWidget(
                                  screenTitle: 'Profile',
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                          'https://ntrepidcorp.com/wp-content/uploads/2016/06/team-1.jpg'),
                                    ),
                                    const SizedBox(width: 60),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(userName,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 26,
                                                fontFamily: 'NotoSan',
                                                fontWeight: FontWeight.w600)),
                                        const Text(
                                          'Student',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'NotoSan'),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                //lists of options
                OptionsListWidget(
                  icon: Icons.person_2_outlined,
                  title: 'Personal Info',
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const PersonalInfoScreen()));
                  },
                ),
                OptionsListWidget(
                  icon: Icons.settings,
                  title: 'Setting',
                  onPressed: () {},
                ),
                OptionsListWidget(
                  icon: Icons.help_center,
                  title: 'Support',
                  onPressed: () {},
                ),
                OptionsListWidget(
                  icon: Icons.policy,
                  title: 'Privacy and Policy',
                  onPressed: () {},
                ),
                Divider(
                  color: Colors.grey[400],
                  indent: 16,
                  endIndent: 18,
                ),
                OptionsListWidget(
                  icon: Icons.logout,
                  title: 'Logout',
                  color: Colors.white,
                  onPressed: () {
                    supabase.auth.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
