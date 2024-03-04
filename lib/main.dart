import 'package:Hostinaar/onboardingScreen.dart';
import 'package:Hostinaar/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: 'https://yuwnpdigaavzpcztqhba.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl1d25wZGlnYWF2enBjenRxaGJhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDkzNzg1MjksImV4cCI6MjAyNDk1NDUyOX0.nz28WikelER0vLoMgpP6KlbAHmX0FSmZH5EbTKoac5U');
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var currentUser = supabase.auth.currentUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //remove the debug banner
      debugShowCheckedModeBanner: false,
      home: currentUser != null ? const DashboardScreen() : const OnboardingScreen(),
    );
  }
}
