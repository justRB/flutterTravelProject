import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_travel_project/blocs/users_cubit.dart';
import 'package:flutter_travel_project/ui/widgets/custom_form_button.dart';
import 'package:flutter_travel_project/ui/widgets/header.dart';
import '../widgets/custom_form_field.dart';

class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    void usernameValue(String value) {
      setState(() {
        username = value;
      });
    }

    void emailValue(String value) {
      setState(() {
        email = value;
      });
    }

    void passwordValue(String value) {
      setState(() {
        password = value;
      });
    }

    void onPressed() async {
      if (_formKey.currentState!.validate()) {
        await context
            .read<UsersCubit>()
            .register(username, email, password)
            .then(
              (inscription) => {
                inscription
                    ? Navigator.of(context).pushNamedAndRemoveUntil(
                        '/connection', (Route<dynamic> route) => false)
                    : null
              },
            );
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const Header(
        title: "S'inscrire",
        showProfile: false,
        showReturn: true,
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomFormField(
                fieldValue: usernameValue,
                placeHolder: "Nom d'utilisateur",
                percent: 0.8,
                symetricVertical: 20,
                symetricHorizontal: 20,
                textSize: 14,
                borderRadius: 16,
                wrongValueMessage:
                    "Veuillez entrer un nom d'utilisateur valide",
                maxLetters: 13,
                hiddentext: false,
              ),
              const SizedBox(height: 15),
              CustomFormField(
                fieldValue: emailValue,
                placeHolder: 'Adresse mail',
                percent: 0.8,
                symetricVertical: 20,
                symetricHorizontal: 20,
                textSize: 14,
                borderRadius: 16,
                wrongValueMessage: 'Veuillez entrer une addresse mail valide',
                maxLetters: 32,
                hiddentext: false,
              ),
              const SizedBox(height: 15),
              CustomFormField(
                fieldValue: passwordValue,
                placeHolder: 'Mot de passe',
                percent: 0.8,
                symetricVertical: 20,
                symetricHorizontal: 20,
                textSize: 14,
                borderRadius: 16,
                wrongValueMessage: 'Veuillez entrer un mot de passe valide',
                maxLetters: 32,
                hiddentext: true,
              ),
              const SizedBox(height: 15),
              CustomFormButton(
                onPressed: onPressed,
                textButton: 'inscription',
                textSize: 14,
                borderRadius: 8,
                paddingRadius: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
