import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_travel_project/models/user_class.dart';
import 'package:flutter_travel_project/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersCubit extends Cubit<bool> {
  UsersCubit(
    this.userRepository,
    this.firebaseAuth,
    this.firebaseFirestore,
  ) : super(false);

  final UserRepository userRepository;
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  late UserClass userClient;

  Future<bool> register(String username, String email, String password) async {
    return await userRepository.register(
        firebaseAuth, firebaseFirestore, username, email, password);
  }

  Future<UserClass> login(String email, String password) async {
    UserClass user = await userRepository.login(
        firebaseAuth, firebaseFirestore, email, password);

    emit(user.uid != '');
    userClient = user;
    return userClient;
  }

  Future<UserClass> isLoged(
      FirebaseAuth firebaseAuth, FirebaseFirestore firebaseFirestore) async {
    UserClass user =
        await userRepository.isLoged(firebaseAuth, firebaseFirestore);
    emit(user.uid != '');
    userClient = user;
    return userClient;
  }

  Future<bool> deconnection() async {
    bool success = await userRepository.deconnection(firebaseAuth);
    emit(!success);
    return success;
  }
}
