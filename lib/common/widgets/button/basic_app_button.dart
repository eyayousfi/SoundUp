import 'package:flutter/material.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double? height;
  final Color? color;

  const BasicAppButton({
    required this.onPressed,
    required this.title,
    this.height,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(height ?? 65), backgroundColor: color,
      ),
      child: Text(
        title,
        style: TextStyle(color: Colors.white), // Adjust text color as needed
      ),
    );
  }
}
