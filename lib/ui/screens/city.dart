import 'package:flutter/material.dart';

import '../widgets/header.dart';

class City extends StatefulWidget {
  const City({super.key});

  @override
  State<City> createState() => _CityState();
}

class _CityState extends State<City> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: Header(
        title: "Explorer les avis",
        showProfile: true,
        showReturn: true,
      ),
    );
  }
}
