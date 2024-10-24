import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final Color textColor;

  final VoidCallback onPressed;

  const CustomButton(
      {required this.child,
      required this.onPressed,
      required this.backgroundColor,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(500, 50),
        backgroundColor:
            backgroundColor, // Set the background color of the button
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Set the button shape
        ),
      ),
      child: child,
    );
  }
}
