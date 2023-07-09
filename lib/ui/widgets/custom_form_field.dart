import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormField extends StatefulWidget {
  final void Function(String) fieldValue;
  final String placeHolder;
  final double percent;
  final double symetricVertical;
  final double symetricHorizontal;
  final double textSize;
  final double borderRadius;
  final String wrongValueMessage;
  final int maxLetters;
  final bool hiddentext;

  const CustomFormField({
    required this.fieldValue,
    required this.placeHolder,
    required this.percent,
    required this.symetricVertical,
    required this.symetricHorizontal,
    required this.textSize,
    required this.borderRadius,
    required this.wrongValueMessage,
    required this.maxLetters,
    required this.hiddentext,
    super.key,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * widget.percent,
          child: TextFormField(
            obscureText: widget.hiddentext,
            controller: textController,
            maxLength: widget.maxLetters,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            focusNode: FocusNode(canRequestFocus: false),
            decoration: InputDecoration(
              counterText: '',
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
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: Builder(
            builder: (BuildContext context) {
              return Text(
                "${textController.text.length}/${widget.maxLetters}",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
