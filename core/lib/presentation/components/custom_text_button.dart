import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final Color color;
  final double width;
  final String text;
  final Function() onTap;
  const CustomTextButton({
    Key? key,
    required this.color,
    required this.width,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        primary: color,
        minimumSize: Size(
          (width < 300) ? 300 : width,
          50,
        ),
        maximumSize: Size(
          (width > 500) ? 500 : width,
          50,
        ),
      ),
      child: Text(
        text,
      ),
    );
  }
}
