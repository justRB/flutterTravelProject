import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_travel_project/blocs/publications_cubit.dart';
import 'package:flutter_travel_project/blocs/users_cubit.dart';
import 'package:flutter_travel_project/models/publication_class.dart';
import 'package:flutter_travel_project/ui/widgets/custom_form_button.dart';
import 'package:flutter_travel_project/ui/widgets/custom_form_field.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/city_class.dart';
import '../widgets/header.dart';

class Publication extends StatefulWidget {
  const Publication({super.key});

  @override
  State<Publication> createState() => _PublicationState();
}

class _PublicationState extends State<Publication> {
  File? _selectedImage;
  double value = 0.0;
  double score = 0;
  String comment = '';

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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: AspectRatio(
                aspectRatio: 1.2,
                child: _selectedImage != null
                    ? Image.file(_selectedImage!)
                    : Container(),
              ),
            ),
            const SizedBox(height: 25),
            CustomFormButton(
              onPressed: _pickImageFromGallery,
              textButton: 'choisir une photo',
              textSize: 14,
              borderRadius: 8,
              paddingRadius: 10,
            ),
            Slider(
              thumbColor: Colors.yellow,
              activeColor: Colors.yellow,
              value: value,
              min: 0.0,
              max: 50.0,
              divisions: 50,
              onChanged: (newValue) {
                setState(() {
                  value = newValue;
                });
              },
              onChangeEnd: (newValue) {
                score = newValue / 10;
              },
            ),
            Text(
              (value / 10).toStringAsFixed(1),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.yellow,
              ),
            ),
            const SizedBox(height: 25),
            CustomFormField(
              fieldValue: commentValue,
              placeHolder: 'Commentaire',
              percent: 0.8,
              symetricVertical: 20,
              symetricHorizontal: 20,
              textSize: 14,
              borderRadius: 16,
              wrongValueMessage: 'Veuillez entrer un message valide',
              maxLetters: 400,
              hiddentext: false,
            ),
            const SizedBox(height: 25),
            CustomFormButton(
                onPressed: onPressed,
                textButton: 'envoyer',
                textSize: 14,
                borderRadius: 8,
                paddingRadius: 10)
          ],
        ),
      ),
    );
  }

  void onPressed() async {
    if (_selectedImage != null && comment.trim().replaceAll(' ', '') != '') {
      final usersCubit = BlocProvider.of<UsersCubit>(context);
      CityClass cityObject =
          ModalRoute.of(context)!.settings.arguments as CityClass;
      DateTime dateTime = DateTime.now();
      PublicationClass publicationObject = PublicationClass(
        author: usersCubit.userClient.username,
        uid: usersCubit.userClient.uid,
        city: cityObject.name,
        imageUrl: _selectedImage!,
        comment: comment,
        date: Timestamp.fromDate(dateTime),
        score: score,
      );
      await context
          .read<PublicationsCubit>()
          .addPublication(publicationObject)
          .then((success) => success
              ? Navigator.pushReplacementNamed(
                  context,
                  '/city',
                  arguments:
                      CityClass(name: cityObject.name, score: cityObject.score),
                )
              : null);
    }
  }

  void commentValue(String value) {
    setState(() {
      comment = value;
    });
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
