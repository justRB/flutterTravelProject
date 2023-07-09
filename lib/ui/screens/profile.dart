import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_travel_project/blocs/users_cubit.dart';
import 'package:flutter_travel_project/ui/widgets/custom_form_button.dart';
import 'package:flutter_travel_project/ui/widgets/header.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    void deconnection() async {
      await context.read<UsersCubit>().deconnection().then(
            (deconnection) => {
              deconnection
                  ? Navigator.of(context).pushNamedAndRemoveUntil(
                      '/connection', (Route<dynamic> route) => false)
                  : null
            },
          );
    }

    final usersCubit = BlocProvider.of<UsersCubit>(context);
    return Scaffold(
      appBar: const Header(
        title: 'Profil utilisateur',
        showProfile: false,
        showReturn: true,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nom d'utilisateur :",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Addresse mail :',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(usersCubit.userClient.username),
                      Text(usersCubit.userClient.email),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            CustomFormButton(
              onPressed: deconnection,
              textButton: 'déconnexion',
              textSize: 14,
              borderRadius: 8,
              paddingRadius: 10,
            ),
          ],
        ),
      ),
    );
  }
}
