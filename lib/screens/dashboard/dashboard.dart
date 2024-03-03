import 'package:flutter/material.dart';
import 'package:polygoniar/components/drawer.dart';
import 'package:polygoniar/components/infoCard.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

 

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  String greetings(){
    var hour = DateTime.now().hour;
    if(hour < 12){
      return 'Good Morning';
    } else if(hour < 17){
      return 'Good Afternoon';
    } else{
      return 'Good Evening';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    greetings();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/finalBg.jpg'),
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
                    trailing: const CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://ntrepidcorp.com/wp-content/uploads/2016/06/team-1.jpg',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    '${greetings()} Kato',
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
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 3),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      InfoCard(
                        title: 'Current Hostel',
                        icon: Icons.home,
                        info: 'Mandela Hostel',
                        onTap: () {
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
                          // Navigate to Notifications screen
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
