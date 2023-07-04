import 'package:flutter/material.dart';
import 'package:flutter_travel_project/ui/widgets/publication_card.dart';

import '../../models/city_class.dart';
import '../widgets/header.dart';

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
            Expanded(
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.only(left: 25, right: 25),
                      child: const PublicationCard(
                        authorFirstname: 'Fabien',
                        authorLastName: 'Dubois',
                        imageUrl: 'paris.jpg',
                        comment:
                            '123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 ',
                        date: '04/07/2023 - 13:59',
                        score: 4.3,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
