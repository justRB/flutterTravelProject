import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_travel_project/models/publication_class.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;

class PublicationRepository {
  fs.Reference storageRef =
      fs.FirebaseStorage.instance.ref().child('publications');

  Future<List<PublicationClass>> loadPublications(
      FirebaseFirestore firebaseFirestore, String cityName) async {
    CollectionReference publicationsCollection =
        firebaseFirestore.collection('publications');
    QuerySnapshot snapshot = await publicationsCollection
        .where('publication_city', isEqualTo: cityName)
        .get();

    final List<PublicationClass> publications = [];

    for (var element in snapshot.docs) {
      PublicationClass publicationObject = PublicationClass(
        uid: element.get('publication_uid'),
        city: element.get('publication_city'),
        author: element.get('publication_author'),
        imageUrl: null,
        imageHttp: element.get('publication_imageUrl'),
        comment: element.get('publication_comment'),
        date: element.get('publication_date'),
        score: element.get('publication_score'),
      );

      publications.add(publicationObject);
    }

    return publications;
  }

  Future<bool> addPublication(FirebaseFirestore firebaseFirestore,
      PublicationClass publicationObject) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      fs.UploadTask uploadTask =
          storageRef.child(fileName).putFile(publicationObject.imageUrl!);
      fs.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

      String downloadURL = await taskSnapshot.ref.getDownloadURL();

      CollectionReference publications =
          firebaseFirestore.collection('publications');

      await publications.add({
        'publication_uid': publicationObject.uid,
        'publication_author': publicationObject.author,
        'publication_city': publicationObject.city,
        'publication_imageUrl': downloadURL,
        'publication_comment': publicationObject.comment,
        'publication_date': publicationObject.date,
        'publication_score': publicationObject.score,
      });

      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<List<PublicationClass>> loadUserPublications(
      FirebaseFirestore firebaseFirestore, String uid) async {
    CollectionReference publicationsCollection =
        firebaseFirestore.collection('publications');
    QuerySnapshot snapshot = await publicationsCollection
        .where('publication_uid', isEqualTo: uid)
        .get();

    final List<PublicationClass> publications = [];

    for (var element in snapshot.docs) {
      PublicationClass publicationObject = PublicationClass(
        uid: element.get('publication_uid'),
        city: element.get('publication_city'),
        author: element.get('publication_author'),
        imageUrl: null,
        imageHttp: element.get('publication_imageUrl'),
        comment: element.get('publication_comment'),
        date: element.get('publication_date'),
        score: element.get('publication_score'),
      );

      publications.add(publicationObject);
    }

    return publications;
  }
}
