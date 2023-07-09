import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import '../models/city_class.dart';

class CityRepository {
  String apiKey = 'testtest';

  final dio = Dio(BaseOptions(baseUrl: 'http://api.geonames.org'));

  Future<List<CityClass>> getCities() async {
    final response = await dio.get('/searchJSON', queryParameters: {
      'country': 'FR',
      'maxRows': 1000,
      'username': apiKey,
    });

    if (response.statusCode == 200) {
      final List<CityClass> cities = [];

      final data = response.data;
      final geonames = data['geonames'];

      final nameList = [];

      for (dynamic city in geonames) {
        final name = city['name'];
        nameList.add(name);
        nameList.sort();
      }

      for (String name in nameList) {
        cities.add(CityClass(name: name, score: 0.0));
      }

      return cities;
    } else {
      throw Exception();
    }
  }

  Future<CityClass> getCitie(
      FirebaseFirestore firebaseFirestore, String cityName) async {
    try {
      CollectionReference publicationsCollections =
          firebaseFirestore.collection('publications');

      QuerySnapshot snapshot = await publicationsCollections
          .where('publication_city', isEqualTo: cityName)
          .get();

      double totalScore = 0.0;

      for (var element in snapshot.docs) {
        totalScore += element.get('publication_score');
      }

      double score = totalScore / snapshot.docs.length;
      String scoreString = score.toStringAsFixed(1);
      print(score);
      return CityClass(name: cityName, score: double.parse(scoreString));
    } catch (e) {
      log(e.toString());
      return CityClass(name: cityName, score: 0.0);
    }
  }
}
