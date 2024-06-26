import 'dart:io';

import 'package:Hostinaar/Components/drawer.dart';
import 'package:Hostinaar/Components/infoCard.dart';
import 'package:Hostinaar/main.dart';
import 'package:Hostinaar/screens/booking/Booked_hostel.dart';
import 'package:Hostinaar/screens/todo/Todo_ListScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
  });

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late String? userName = '';
  late String? userEmail = '';
  late String? userPic = '';

  String greetings() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  Future getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(
      () {
        userName = prefs.getString('userName');
        userEmail = supabase.auth.currentUser!.email;
        userPic = prefs.getString('profilePic');
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    greetings();
    getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(
        email: userEmail,
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/finalBg.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Builder(
                  builder: (context) => ListTile(
                    leading: InkWell(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: const Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    trailing: userPic != null && userPic!.isNotEmpty
                        ? CircleAvatar(
                            backgroundImage: FileImage(File(userPic!)),
                          )
                        : const CircleAvatar(
                            backgroundImage: AssetImage('images/avatar.png'),
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    '${greetings()} ${userName?.split(' ').first}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 2.0,
                    childAspectRatio: 1.4,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      InfoCard(
                        title: 'Current Hostel',
                        icon: Icons.home,
                        info: 'Mandela Hostel',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const BookedRoomScreen()),
                          );
                          // Navigate to My Bookings screen
                        },
                      ),
                      InfoCard(
                        title: 'Current Room',
                        icon: Icons.bed,
                        info: 'B1R02',
                        onTap: () {
                          // Navigate to Search Hostels screen
                        },
                      ),
                      InfoCard(
                        title: 'Payment Staus',
                        icon: Icons.payments,
                        info: 'Cleared',
                        onTap: () {
                          // Navigate to Profile screen
                        },
                      ),
                      InfoCard(
                        title: 'To do-list',
                        icon: Icons.task,
                        info: 'Pending: 2',
                        onTap: () {
                          // Navigate to todo list screen
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ToDoListScreen()));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
