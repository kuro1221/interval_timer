import 'package:flutter/material.dart';
import 'dart:developer';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Color color;
  final Color backgroundColor;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    this.color = Colors.black,
    this.backgroundColor = Colors.blue,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: backgroundColor,
      padding:  const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 20),
    ),
    onPressed: onClicked,
  );
}