import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    CityClass cityObject =
        ModalRoute.of(context)!.settings.arguments as CityClass;
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
                            publicationObject: PublicationClass(
                              author: 'Fabien',
                              imageUrl: 'paris.jpg',
                              comment:
                                  'La Tour Eiffel de jour sur Paris est magnifique, il fait chaud avec un super soleil, en famille nous continuons notre séjour là-bas. La Tour Eiffel de jour sur Paris est magnifique, il fait chaud avec un super soleil, en famille nous continuons notre séjour là-bas.',
                              date: '04/07/2023 - 13:59',
                              score: 4.3,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Publier un avis'),
                          Icon(Icons.add),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/publication');
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
