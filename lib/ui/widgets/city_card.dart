import 'package:flutter/material.dart';

import '../../models/city_class.dart';

class CityCard extends StatelessWidget {
  final String city;
  final double borderRadius;
  final double score;

  const CityCard({
    required this.city,
    required this.borderRadius,
    required this.score,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    CityClass cityObject = CityClass(name: city, score: score);
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.only(left: 25, right: 25),
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Text(
                city,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Icon(Icons.arrow_right),
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, '/city', arguments: cityObject);
      },
    );
  }
}
