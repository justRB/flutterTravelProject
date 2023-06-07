import 'package:flutter/material.dart';
import 'package:flutter_travel_project/ui/widgets/header.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: Header(),
    );
  }
}