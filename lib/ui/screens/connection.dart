import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_travel_project/ui/widgets/custom_form_button.dart';
import 'package:flutter_travel_project/ui/widgets/header.dart';
import '../../blocs/users_cubit.dart';
import '../widgets/custom_form_field.dart';

class Connection extends StatefulWidget {
  const Connection({super.key});

  @override
  State<Connection> createState() => _ConnectionState();
}

class _ConnectionState extends State<Connection> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
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
        await context.read<UsersCubit>().login(email, password).then(
              (userClient) => {
                userClient.uid != ''
                    ? Navigator.of(context).pushNamedAndRemoveUntil(
                        '/welcome', (Route<dynamic> route) => false)
                    : null
              },
            );
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const Header(
        title: 'Se connecter',
        showProfile: false,
        showReturn: false,
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Column(
                children: [
                  CustomFormField(
                    fieldValue: emailValue,
                    placeHolder: 'Adresse mail',
                    percent: 0.8,
                    symetricVertical: 20,
                    symetricHorizontal: 20,
                    textSize: 14,
                    borderRadius: 16,
                    wrongValueMessage:
                        'Veuillez entrer une addresse mail valide',
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
                    textButton: 'connexion',
                    textSize: 14,
                    borderRadius: 8,
                    paddingRadius: 10,
                  ),
                ],
              ),
              GestureDetector(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: const Text(
                    'inscription',
                    style: TextStyle(
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                      color: Colors.white,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/inscription');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
