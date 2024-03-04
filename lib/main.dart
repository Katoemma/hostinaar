import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Hostinaar/onboardingScreen.dart';
import 'package:Hostinaar/screens/dashboard/dashboard.dart';
import 'package:Hostinaar/screens/login/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://yuwnpdigaavzpcztqhba.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl1d25wZGlnYWF2enBjenRxaGJhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDkzNzg1MjksImV4cCI6MjAyNDk1NDUyOX0.nz28WikelER0vLoMgpP6KlbAHmX0FSmZH5EbTKoac5U',
  );
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<Widget> determineFirstScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    var currentUser = supabase.auth.currentUser;
    if (isFirstTime) {
      return const OnboardingScreen();
    } else if (currentUser != null) {
      return const DashboardScreen();
    } else {
      return const LoginScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: determineFirstScreen(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Return a loading indicator or placeholder widget
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          // Handle error
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            ),
          );
        } else {
          // Return the widget returned by determineFirstScreen()
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: snapshot.data,
          );
        }
      },
    );
  }
}
