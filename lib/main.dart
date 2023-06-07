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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Welcome(),
    );
  }
}
