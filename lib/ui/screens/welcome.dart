import 'package:flutter/material.dart';
import 'package:flutter_travel_project/ui/widgets/city_card.dart';
import 'package:flutter_travel_project/ui/widgets/header.dart';
import 'package:flutter_travel_project/ui/widgets/research_bar.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  List<String> cities = ["Angers", "Tours", "Paris", "Lyon", "Bordeaux"];
  List<String> filteredCities = [];

  @override
  void initState() {
    super.initState();
    filteredCities = cities;
  }

  void filterCities(String query) {
    setState(() {
      filteredCities = cities
          .where((city) => city.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(
        title: 'Découvrez nos villes de France',
        showProfile: true,
        showReturn: false,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ResearchBar(
              filter: filterCities,
              placeholder: 'Rechercher une ville...',
              percent: 0.8,
              height: 20.0,
              textSize: 14,
              borderRadius: 16,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 25, bottom: 25),
                width: MediaQuery.of(context).size.width * 0.8,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: filteredCities.length,
                  itemBuilder: (context, index) {
                    return CityCard(
                      city: filteredCities[index].toString(),
                      borderRadius: 16,
                      score: 4.5,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
