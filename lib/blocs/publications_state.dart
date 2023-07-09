import 'package:flutter_travel_project/models/data_class.dart';
import 'package:flutter_travel_project/models/publication_class.dart';

class PublicationsState {
  DataState dataState;
  List<PublicationClass> publications;

  PublicationsState(this.dataState, [this.publications = const []]);

  factory PublicationsState.loading() => PublicationsState(DataState.loading);

  factory PublicationsState.loaded(List<PublicationClass> publications) =>
      PublicationsState(DataState.loaded, publications);

  factory PublicationsState.error() => PublicationsState(DataState.error);
}
