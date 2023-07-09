import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_travel_project/blocs/cities_cubit.dart';
import 'package:flutter_travel_project/blocs/publications_cubit.dart';
import 'package:flutter_travel_project/blocs/users_cubit.dart';
import 'package:flutter_travel_project/repositories/city_repository.dart';
import 'package:flutter_travel_project/repositories/publication_repository.dart';
import 'package:flutter_travel_project/repositories/user_repository.dart';
import 'package:flutter_travel_project/ui/screens/connection.dart';
import 'package:flutter_travel_project/ui/screens/inscription.dart';
import 'package:flutter_travel_project/ui/screens/welcome.dart';
import 'package:flutter_travel_project/ui/screens/publication.dart';

import 'ui/screens/city.dart';
import 'ui/screens/profile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  UsersCubit usersCubit = UsersCubit(
    UserRepository(),
    FirebaseAuth.instance,
    FirebaseFirestore.instance,
  );

  await usersCubit.isLoged(FirebaseAuth.instance, FirebaseFirestore.instance);

  runApp(MultiBlocProvider(providers: [
    BlocProvider(
        create: (_) =>
            CitiesCubit(CityRepository(), FirebaseFirestore.instance)),
    BlocProvider(
      create: (_) => usersCubit,
    ),
    BlocProvider(
        create: (_) => PublicationsCubit(
            PublicationRepository(), FirebaseFirestore.instance)),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/welcome': (context) => const Welcome(),
        '/city': (context) => const City(),
        '/profile': (context) => const Profile(),
        '/connection': (context) => const Connection(),
        '/inscription': (context) => const Inscription(),
        '/publication': (context) => const Publication(),
      },
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 0, 100, 148),
      ),
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<UsersCubit, bool>(
        builder: (context, isLoged) =>
            isLoged ? const Welcome() : const Connection(),
      ),
    );
  }
}
