import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_travel_project/blocs/cities_state.dart';
import 'package:flutter_travel_project/repositories/city_repository.dart';

class CitiesCubit extends Cubit<CitiesState> {
  CitiesCubit(this.cityRepository) : super(CitiesState.loading());

  final CityRepository cityRepository;

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
}
