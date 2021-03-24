import 'package:flutter/material.dart';

class TextFeilds extends StatelessWidget {
  final Function onChange;
  final String hint;

  TextFeilds({this.onChange, this.hint});
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: hint),
      onChanged: onChange
    );
  }
}
