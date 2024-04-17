import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final Color ? borderColor;
  final bool ? obscureText;
   String? Function(String?)? validator;


   CustomTextField({

    Key? key,
    required this.hintText,
    required this.labelText,
    required this.controller,
    this.borderColor,
    this.obscureText,
    this.validator

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText??false,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide:  BorderSide(color:borderColor?? Colors.grey),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}