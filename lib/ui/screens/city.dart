import 'package:flutter/material.dart';
import 'package:flutter_travel_project/ui/widgets/publication_card.dart';
import '../widgets/header.dart';
import '../../models/city_class.dart';

class City extends StatefulWidget {
  const City({super.key});

  @override
  State<City> createState() => _CityState();
}

class _CityState extends State<City> {
  @override
  Widget build(BuildContext context) {
    CityClass cityObject =
        ModalRoute.of(context)!.settings.arguments as CityClass;
    return Scaffold(
      appBar: const Header(
        title: "Explorer les avis",
        showProfile: true,
        showReturn: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              cityObject.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  cityObject.score.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                const Icon(
                  Icons.star,
                  color: Color.fromARGB(255, 255, 209, 59),
                ),
              ],
            ),
            PublicationCard(),
          ],
        ),
      ),
    );
  }
}
