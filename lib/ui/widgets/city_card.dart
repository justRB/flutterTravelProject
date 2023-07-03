import 'package:flutter/material.dart';

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
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            city,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Text(score.toString()),
              const Icon(
                Icons.star,
                color: Color.fromARGB(255, 255, 209, 59),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
