import 'package:flutter/material.dart';
import 'package:flutter_travel_project/ui/screens/welcome.dart';

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
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 0, 148, 216),
      ),
      debugShowCheckedModeBanner: false,
      home: const Welcome(),
    );
  }
}
