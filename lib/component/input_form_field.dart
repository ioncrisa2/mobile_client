import 'package:flutter/material.dart';

class InputFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool obscureText;
  final Icon icon;
  final int lines;
  final Future<dynamic> ontap;

  const InputFormField({
    Key key,
    this.controller,
    this.label,
    this.hint,
    this.obscureText = false,
    this.icon,
    this.lines = 1,
    this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      maxLines: lines,
      onTap: () => ontap,
      decoration: InputDecoration(
        prefixIcon: icon,
        hintText: hint,
        labelText: label,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
