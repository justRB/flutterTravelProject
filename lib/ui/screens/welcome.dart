import 'package:flutter/material.dart';
import 'package:flutter_travel_project/ui/widgets/header.dart';
import 'package:flutter_travel_project/ui/widgets/research_bar.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(title: 'Découvrez nos villes de France'),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            ResearchBar(
              placeholder: 'Rechercher une ville...',
              percent: 0.8,
              height: 20.0,
              textSize: 14,
              borderRadius: 16,
            ),
          ],
        ),
      ),
    );
  }
}
