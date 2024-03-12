import 'package:Hostinaar/helpers/constants.dart';
import 'package:Hostinaar/main.dart';
import 'package:flutter/material.dart';

class HostelListingScreen extends StatefulWidget {
  const HostelListingScreen({Key? key}) : super(key: key);

  @override
  State<HostelListingScreen> createState() => _HostelListingScreenState();
}

class _HostelListingScreenState extends State<HostelListingScreen> {
  List<Map<String, dynamic>> hostels = [];

  @override
  void initState() {
    super.initState();
    fetchHostels();
  }

  Future<void> fetchHostels() async {
    final response = await supabase.from('Hostels').select('*');

    if (response != null) {
      setState(() {
        hostels = response as List<Map<String, dynamic>>;
      });
      // Handle error
    } else {
      print('Error fetching hostels: ${response}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[300],
                        hintText: 'Location',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  const TabBar(
                    indicatorColor: kSecondaryColor,
                    labelColor: kSecondaryColor,
                    unselectedLabelColor: kPrimaryColor,
                    tabs: [
                    Tab(text: 'Girls Hostels'),
                    Tab(text: 'Single Rooms'),
                    Tab(text: 'Double Rooms'),
                  ]),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 150.0,
                    child: TabBarView(children: [
                      ListView.builder(
                        itemCount: hostels.length,
                        itemBuilder: (context, index) {
                          final hostel = hostels[index];
                          return ListTile(
                            leading: Image.network(
                              hostel['Image'],
                              width: 50, // Adjust width as needed
                              height: 50, // Adjust height as needed
                            ),
                            title: Text(hostel['Hostel Name']),
                            subtitle: Text(hostel['Location']),
                            trailing: Text('${hostel['Monthly Rent (USD)']}'),
                          );
                        },
                      ),
                      ListView.builder(
                        itemCount: hostels.length,
                        itemBuilder: (context, index) {
                          final hostel = hostels[index];
                          return ListTile(
                            leading: Image.network(
                              hostel['Image'],
                              width: 50, // Adjust width as needed
                              height: 50, // Adjust height as needed
                            ),
                            title: Text(hostel['Hostel Name']),
                            subtitle: Text(hostel['Location']),
                            trailing: Text('${hostel['Monthly Rent (USD)']}'),
                          );
                        },
                      ),
                      ListView.builder(
                        itemCount: hostels.length,
                        itemBuilder: (context, index) {
                          final hostel = hostels[index];
                          return Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(12)),
                                  child: Image.network(
                                    hostel['Image'],
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        hostel['Hostel Name'],
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Location: ${hostel['Location']}',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Monthly Rent: \$${hostel['Monthly Rent (USD)']}',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
