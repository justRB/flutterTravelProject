import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_travel_project/blocs/cities_state.dart';
import 'package:flutter_travel_project/models/city_class.dart';
import 'package:flutter_travel_project/repositories/city_repository.dart';

class CitiesCubit extends Cubit<CitiesState> {
  CitiesCubit(this.cityRepository, this.firebaseFirestore)
      : super(CitiesState.loading());

  final CityRepository cityRepository;
  final FirebaseFirestore firebaseFirestore;
  CityClass cityObject = const CityClass(name: '', score: 0.0);

  Future<void> loadCities() async {
    try {
      emit(CitiesState.loading());
      final cities = await cityRepository.getCities();
      emit(CitiesState.loaded(cities));
    } catch (e) {
      log(e.toString());
      emit(CitiesState.error());
    }
  }

  Future<CityClass> getCitie(String cityName) async {
    CityClass city = await cityRepository.getCitie(firebaseFirestore, cityName);
    cityObject = city;
    return city;
  }
}
