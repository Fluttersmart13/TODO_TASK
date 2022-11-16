import 'package:flutter/material.dart';
import 'package:to_do/view/constants.dart';

class SimpleTextWidget extends StatelessWidget {
  final String title;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;

  SimpleTextWidget(
      {required this.title,
      required this.fontSize,
      required this.color,
      required this.fontWeight})
      : super();

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
          color: color ?? koTextColor,
          overflow: TextOverflow.ellipsis),
    );
  }
}
