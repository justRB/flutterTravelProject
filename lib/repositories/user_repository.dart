import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_travel_project/models/user_class.dart';

class UserRepository {
  Future<bool> register(
      FirebaseAuth firebaseAuth,
      FirebaseFirestore firebaseFirestore,
      String username,
      String email,
      String password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String? userUid = userCredential.user?.uid;

      CollectionReference users = firebaseFirestore.collection('users');

      await users.add({
        'user_uid': userUid,
        'user_username': username,
      });

      firebaseAuth.signOut();

      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<UserClass> login(FirebaseAuth firebaseAuth,
      FirebaseFirestore firebaseFirestore, email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      String? uid = userCredential.user?.uid;

      UserClass userClient = await userData(
          firebaseAuth, firebaseFirestore, uid.toString(), email);

      return userClient;
    } catch (e) {
      log(e.toString());
      return const UserClass(uid: '', username: '', email: '');
    }
  }

  Future<UserClass> isLoged(
      FirebaseAuth firebaseAuth, FirebaseFirestore firebaseFirestore) async {
    try {
      User? user = firebaseAuth.currentUser;

      String? uid = user?.uid;
      String? email = user?.email;

      UserClass userClient = await userData(
          firebaseAuth, firebaseFirestore, uid.toString(), email.toString());

      return userClient;
    } catch (e) {
      log(e.toString());
      return const UserClass(uid: '', username: '', email: '');
    }
  }

  Future<bool> deconnection(FirebaseAuth firebaseAuth) async {
    try {
      firebaseAuth.signOut();
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<UserClass> userData(FirebaseAuth firebaseAuth,
      FirebaseFirestore firebaseFirestore, String uid, String email) async {
    CollectionReference usersCollection = firebaseFirestore.collection('users');

    QuerySnapshot snapshot = await usersCollection
        .where('user_uid', isEqualTo: uid.toString())
        .limit(1)
        .get();

    DocumentSnapshot document = snapshot.docs.first;
    String username = document['user_username'];

    UserClass userClient = UserClass(
      uid: uid.toString(),
      username: username,
      email: email.toString(),
    );

    return userClient;
  }
}
