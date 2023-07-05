import 'package:flutter/material.dart';

class CustomFormButton extends StatelessWidget {
  final void Function() onPressed;
  final String textButton;
  final double textSize;
  final double borderRadius;
  final double paddingRadius;

  const CustomFormButton({
    required this.onPressed,
    required this.textButton,
    required this.textSize,
    required this.borderRadius,
    required this.paddingRadius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(paddingRadius),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Text(
          textButton,
          style: TextStyle(fontSize: textSize),
        ),
      ),
      onTap: () {
        onPressed.call();
      },
    );
  }
}

// ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     print('Adresse mail: $email');
//                     print('Mot de passe: $password');
//                   }
//                 },
//                 child: const Text('Se connecter'),
//               ),