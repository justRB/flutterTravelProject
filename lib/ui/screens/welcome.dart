import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_travel_project/blocs/cities_cubit.dart';
import 'package:flutter_travel_project/blocs/cities_state.dart';
import 'package:flutter_travel_project/models/data_class.dart';
import 'package:flutter_travel_project/ui/widgets/city_card.dart';
import 'package:flutter_travel_project/ui/widgets/header.dart';
import 'package:flutter_travel_project/ui/widgets/research_bar.dart';

import '../../models/city_class.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  List<CityClass> displayCities = [];

  @override
  void initState() {
    super.initState();
    context.read<CitiesCubit>().loadCities();
  }

  void filterCities(String query) {
    final allCities = context.read<CitiesCubit>().state.cities;
    setState(() {
      displayCities = allCities
          .where(
              (city) => city.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Widget citiesBlocBuilder() {
    return BlocBuilder<CitiesCubit, CitiesState>(
      builder: (context, state) {
        switch (state.dataState) {
          case DataState.loading:
            return Container(
              margin: const EdgeInsets.only(top: 75),
              child: const CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          case DataState.loaded:
            if (displayCities.isEmpty) {
              displayCities = state.cities;
            }
            return citiesBuild();
          case DataState.error:
            return GestureDetector(
              child: Container(
                margin: const EdgeInsets.only(top: 75),
                child: const Text(
                  'Erreur, rechargez la page',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.red,
                  ),
                ),
              ),
              onTap: () {
                context.read<CitiesCubit>().loadCities();
              },
            );
          default:
            return Container(
              margin: const EdgeInsets.only(top: 75),
              child: const Text(
                'Erreur inattendue',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.red,
                ),
              ),
            );
        }
      },
    );
  }

  Widget citiesBuild() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 25, bottom: 25),
        width: MediaQuery.of(context).size.width * 0.8,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: displayCities.length,
          itemBuilder: (context, index) {
            final CityClass city = displayCities[index];
            return CityCard(
              city: city.name,
              borderRadius: 16,
              score: city.score,
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            citiesBlocBuilder(),
          ],
        ),
      ),
    );
  }
}
