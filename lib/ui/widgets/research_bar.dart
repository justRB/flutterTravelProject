import 'package:flutter/material.dart';

class ResearchBar extends StatefulWidget {
  final void Function(String) filter;
  final String placeholder;
  final double percent;
  final double height;
  final double textSize;
  final double borderRadius;

  const ResearchBar({
    required this.filter,
    required this.placeholder,
    required this.percent,
    required this.height,
    required this.textSize,
    required this.borderRadius,
    super.key,
  });

  @override
  State<ResearchBar> createState() => _ResearchBarState();
}

class _ResearchBarState extends State<ResearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      width: MediaQuery.of(context).size.width * widget.percent,
      child: TextField(
        onChanged: (value) {
          widget.filter.call(value);
        },
        style: TextStyle(fontSize: widget.textSize),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: widget.height),
          hintText: widget.placeholder,
          hintStyle: const TextStyle(
            color: Color.fromARGB(86, 158, 158, 158),
          ),
          border: InputBorder.none,
          icon: const Icon(
            Icons.search,
            color: Color.fromARGB(158, 0, 129, 161),
          ),
        ),
      ),
    );
  }
}
