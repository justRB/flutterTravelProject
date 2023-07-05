import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  final void Function(String) fieldValue;
  final String placeHolder;
  final double percent;
  final double symetricVertical;
  final double symetricHorizontal;
  final double textSize;
  final double borderRadius;
  final String wrongValueMessage;

  const CustomFormField({
    required this.fieldValue,
    required this.placeHolder,
    required this.percent,
    required this.symetricVertical,
    required this.symetricHorizontal,
    required this.textSize,
    required this.borderRadius,
    required this.wrongValueMessage,
    super.key,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * widget.percent,
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: widget.symetricVertical,
              horizontal: widget.symetricHorizontal),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: BorderSide.none,
          ),
          hintText: widget.placeHolder,
          hintStyle: const TextStyle(
            fontSize: 14,
            color: Color.fromARGB(86, 158, 158, 158),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return widget.wrongValueMessage;
          }
          return null;
        },
        onChanged: (value) {
          widget.fieldValue.call(value);
        },
      ),
    );
  }
}
