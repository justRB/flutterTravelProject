import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_travel_project/blocs/cities_cubit.dart';
import 'package:flutter_travel_project/blocs/publications_cubit.dart';
import 'package:flutter_travel_project/blocs/publications_state.dart';
import 'package:flutter_travel_project/models/data_class.dart';
import 'package:flutter_travel_project/models/publication_class.dart';
import 'package:flutter_travel_project/ui/widgets/publication_card.dart';

import '../../models/city_class.dart';
import '../widgets/header.dart';

class City extends StatefulWidget {
  const City({super.key});

  @override
  State<City> createState() => _CityState();
}

class _CityState extends State<City> {
  List<PublicationClass> displayPublications = [];
  double cityScore = 0.0;

  final List<String> filterList = <String>[
    'Plus réçents',
    'Plus anciens',
    'Mieux notés',
    'Moins bien notés'
  ];
  late String itemSelected;

  @override
  void initState() {
    super.initState();
    itemSelected = filterList[0];
  }

  Widget publicationsBlocBuilder(String cityName) {
    return BlocBuilder<PublicationsCubit, PublicationsState>(
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
            if (displayPublications.isEmpty) {
              displayPublications = state.publications;

              if (displayPublications.isEmpty) {
                return Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: const Text(
                    'Aucunes publications disponibles',
                    style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                    ),
                  ),
                );
              }
            }
            return publicationsBuild();
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
                context.read<PublicationsCubit>().loadPublications(cityName);
              },
            );
        }
      },
    );
  }

  Widget publicationsBuild() {
    return Expanded(
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: displayPublications.length,
        itemBuilder: (context, index) {
          final PublicationClass publication = displayPublications[index];
          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(left: 25, right: 25),
              child: PublicationCard(
                publicationObject: PublicationClass(
                  uid: publication.uid,
                  city: publication.city,
                  author: publication.author,
                  imageUrl: publication.imageUrl,
                  imageHttp: publication.imageHttp,
                  comment: publication.comment,
                  date: publication.date,
                  score: publication.score,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    CityClass cityObject =
        ModalRoute.of(context)!.settings.arguments as CityClass;
    context.read<PublicationsCubit>().loadPublications(cityObject.name);
    final citiesCubit = context.read<CitiesCubit>().getCitie(cityObject.name);
    citiesCubit.then(
      (CityClass value) {
        cityScore = value.score;
      },
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const Header(
        title: "Explorer les avis",
        showProfile: true,
        showReturn: true,
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  cityObject.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      cityScore.toString(),
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
                publicationsBlocBuilder(cityObject.name),
              ],
            ),
          ),
          Positioned(
            bottom: 25,
            left: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 50,
                    padding: const EdgeInsets.only(left: 10, right: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<String>(
                      underline: const SizedBox(),
                      value: itemSelected,
                      onChanged: (String? newValue) {
                        setState(() {
                          itemSelected = newValue!;
                        });
                      },
                      items: filterList.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.only(left: 10, right: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: 50,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Publier un avis'),
                          Icon(Icons.add),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/publication',
                          arguments: cityObject);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
