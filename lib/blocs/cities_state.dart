import 'package:flutter_travel_project/models/data_class.dart';
import '../models/city_class.dart';

class CitiesState {
  DataState dataState;
  List<CityClass> cities;

  CitiesState(this.dataState, [this.cities = const []]);

  factory CitiesState.loading() => CitiesState(DataState.loading);

  factory CitiesState.loaded(List<CityClass> cities) =>
      CitiesState(DataState.loaded, cities);

  factory CitiesState.error() => CitiesState(DataState.error);
}
