import 'package:flutter/material.dart';
import 'package:flutter_travel_project/ui/screens/connection.dart';
import 'package:flutter_travel_project/ui/screens/inscription.dart';
import 'package:flutter_travel_project/ui/screens/welcome.dart';

import 'ui/screens/city.dart';
import 'ui/screens/profile.dart';

Future<void> main() async {
  await initialization(null);

  runApp(const MyApp());
}

Future initialization(BuildContext? context) async {
  await Future.delayed(const Duration(seconds: 3));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/welcome': (context) => const Welcome(),
        '/city': (context) => const City(),
        '/profile': (context) => const Profile(),
        '/connection': (context) => const Connection(),
        '/inscription': (context) => const Inscription(),
      },
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 0, 100, 148),
      ),
      debugShowCheckedModeBanner: false,
      home: const Welcome(),
    );
  }
}
