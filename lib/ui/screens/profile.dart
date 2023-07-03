import 'package:flutter/material.dart';

import '../widgets/header.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(
        title: "Profil utilisateur",
        showProfile: false,
        showReturn: true,
      ),
      body: Center(
        child: Column(
          children: [
            FloatingActionButton.extended(
                label: const Text("Informations"),
                backgroundColor: const Color.fromARGB(255, 90, 170, 149),
                icon: const Icon(Icons.info),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return InfoPopup(
                        nom: 'Nom',
                        prenom: 'Prenom',
                        dateAnniversaire: 'Date',
                      );
                    },
                  );
                }),
            const SwitchThemeMode(),
            const Text("Vos lieux visités")
          ],
        ),
      ),
    );
  }
}

class InfoPopup extends StatelessWidget {
  final String nom;
  final String prenom;
  final String dateAnniversaire;

  InfoPopup({
    required this.nom,
    required this.prenom,
    required this.dateAnniversaire,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Informations de la personne'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Nom: $nom'),
          Text('Prénom: $prenom'),
          Text('Date d\'anniversaire: $dateAnniversaire'),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Fermer'),
        ),
      ],
    );
  }
}

class SwitchThemeMode extends StatefulWidget {
  const SwitchThemeMode({super.key});

  @override
  State<SwitchThemeMode> createState() => _SwitchThemeModeState();
}

class _SwitchThemeModeState extends State<SwitchThemeMode> {
  bool light = true;

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.light_mode);
      }
      return const Icon(Icons.dark_mode);
    },
  );

  @override
  Widget build(BuildContext context) {
    return Switch(
      thumbIcon: thumbIcon,
      value: light,
      onChanged: (bool value) {
        setState(() {
          light = value;
        });
      },
    );
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
