import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class PublicationClass {
  final String uid;
  final String city;
  final String author;
  final File? imageUrl;
  final String? imageHttp;
  final String comment;
  final Timestamp date;
  final double score;

  PublicationClass({
    required this.uid,
    required this.city,
    required this.author,
    this.imageUrl,
    this.imageHttp,
    required this.comment,
    required this.date,
    required this.score,
  });
}
