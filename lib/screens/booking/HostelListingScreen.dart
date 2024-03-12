import 'package:flutter/material.dart';
import 'package:Hostinaar/helpers/constants.dart';
import 'package:Hostinaar/main.dart';

class HostelListingScreen extends StatefulWidget {
  const HostelListingScreen({super.key});

  @override
  State<HostelListingScreen> createState() => _HostelListingScreenState();
}

class _HostelListingScreenState extends State<HostelListingScreen> {
  List<Map<String, dynamic>> hostels = [];
  late TextEditingController _searchController;
  List<Map<String, dynamic>> filteredHostels = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    fetchHostels();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> fetchHostels() async {
    final response = await supabase.from('Hostels').select('*');

    if (response != null) {
      setState(() {
        hostels = response;
        filteredHostels = List.from(hostels);
      });
    } else {
      print('Error fetching hostels: ${response}');
    }
  }

  void filterHostels(String query) {
  setState(() {
    filteredHostels = hostels.where((hostel) {
      final String name = hostel['Hostel Name'].toLowerCase();
      final String location = hostel['Location'].toLowerCase();
      final String lowercaseQuery = query.toLowerCase();

      return name.contains(lowercaseQuery) || location.contains(lowercaseQuery);
    }).toList();
  });
}


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.white,
          title: const Text('Book Hostel'),
          actions: [
            GestureDetector(
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.tune_outlined),
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: _searchController,
                      onChanged: filterHostels,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[300],
                        hintText: 'Search by Hostel Name or Location',
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
                    height: MediaQuery.of(context).size.height - 250.0,
                    child: TabBarView(children: [
                      ListView.builder(
                        itemCount: filteredHostels.length,
                        itemBuilder: (context, index) {
                          final hostel = filteredHostels[index];
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
                        itemCount: filteredHostels.length,
                        itemBuilder: (context, index) {
                          final hostel = filteredHostels[index];
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
                        itemCount: filteredHostels.length,
                        itemBuilder: (context, index) {
                          final hostel = filteredHostels[index];
                          return Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
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
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Location: ${hostel['Location']}',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Monthly Rent: \$${hostel['Monthly Rent (USD)']}',
                                        style: const TextStyle(fontSize: 16),
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
