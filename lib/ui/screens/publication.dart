import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/header.dart';

class Publication extends StatefulWidget {
  const Publication({super.key});

  @override
  State<Publication> createState() => _PublicationState();
}

class _PublicationState extends State<Publication> {
  File? _selectedImage;
  double _sliderValue = 0.0;
  final TextEditingController _textController = TextEditingController();
  final int _maxLength = 400;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const Header(
        title: 'Publiez votre avis',
        showProfile: true,
        showReturn: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: _selectedImage != null
                      ? DecorationImage(
                          image: FileImage(_selectedImage!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
              ),
              ElevatedButton(
                onPressed: _pickImageFromGallery,
                child: Text('Choisir une photo'),
              ),
              Container(
                margin: const EdgeInsets.only(top: 35),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  children: [
                    const Text('Donnez une note'),
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
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 35),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _textController,
                    maxLength: _maxLength,
                    maxLines: null,
                    decoration: const InputDecoration(
                      labelText: 'Ecrivez votre commentaire',
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 25, bottom: 35),
                child: FloatingActionButton.extended(
                    label: const Text("Publiez"),
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    icon: const Icon(Icons.send),
                    onPressed: () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }
}
