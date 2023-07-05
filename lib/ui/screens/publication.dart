import 'package:flutter/material.dart';

import '../widgets/header.dart';

class Publication extends StatefulWidget {
  const Publication({super.key});

  @override
  State<Publication> createState() => _PublicationState();
}

class _PublicationState extends State<Publication> {
  double _sliderValue = 0.0;
  TextEditingController _textController = TextEditingController();
  int _maxLength = 400;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const Header(
        title: 'Publiez votre avis',
        showProfile: true,
        showReturn: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Text("Séléctionnez une image"),
            const Text("Donnez une note"),
            Slider(
              value: _sliderValue,
              min: 0.0,
              max: 5.0,
              divisions: 50,
              label: _sliderValue.toStringAsFixed(1),
              activeColor: const Color.fromARGB(255, 213, 92, 6),
              thumbColor: const Color.fromARGB(255, 213, 184, 6),
              onChanged: (newValue) {
                setState(() {
                  _sliderValue = newValue;
                });
              },
            ),
            const Icon(
              Icons.star,
              size: 50.0,
              color: Colors.amber,
            ),
            Container(
              margin: const EdgeInsets.only(top: 35),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: _textController,
                maxLength: _maxLength,
                maxLines: null,
                style:
                    const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                decoration: InputDecoration(
                  labelText: 'Commentaire (maximum $_maxLength characters)',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
