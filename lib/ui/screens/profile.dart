import 'package:flutter/material.dart';

import '../widgets/header.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(
        title: "Profil utilisateur",
      ),
      body: Center(
        child: Column(
          children: [
            FloatingActionButton.extended(
                label: const Text("Paramètre"),
                backgroundColor: Colors.green,
                icon: const Icon(Icons.settings),
                onPressed: () {}),
            const SwitchThemeMode(),
            const Text("Vos lieux visités")
          ],
        ),
      ),
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
