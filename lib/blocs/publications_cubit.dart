import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_travel_project/blocs/publications_state.dart';
import 'package:flutter_travel_project/models/publication_class.dart';
import 'package:flutter_travel_project/repositories/publication_repository.dart';

class PublicationsCubit extends Cubit<PublicationsState> {
  PublicationsCubit(this.publicationRepository, this.firebaseFirestore)
      : super(PublicationsState.loading());

  final PublicationRepository publicationRepository;
  final FirebaseFirestore firebaseFirestore;

  Future<void> loadPublications(String cityName) async {
    try {
      emit(PublicationsState.loading());
      final publications = await publicationRepository.loadPublications(
          firebaseFirestore, cityName);
      emit(PublicationsState.loaded(publications));
    } catch (e) {
      log(e.toString());
      emit(PublicationsState.error());
    }
  }

  Future<bool> addPublication(PublicationClass publicationObject) async {
    final success = await publicationRepository.addPublication(
        firebaseFirestore, publicationObject);

    return success;
  }

  Future<void> loadUserPublications(
      FirebaseFirestore firebaseFirestore, String uid) async {
    try {
      emit(PublicationsState.loading());
      final publications = await publicationRepository.loadUserPublications(
          firebaseFirestore, uid);
      emit(PublicationsState.loaded(publications));
    } catch (e) {
      log(e.toString());
      emit(PublicationsState.error());
    }
  }
}
