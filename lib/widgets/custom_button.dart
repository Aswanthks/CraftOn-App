
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red.shade700, 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))// Button color
      ),
      child:  Text(text,style: const TextStyle(color: Colors.white),),
    );
  }
}