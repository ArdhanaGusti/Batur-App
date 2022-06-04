import 'package:flutter/material.dart';

class CustomPrimaryTextButton extends StatelessWidget {
  final double width;
  final String text;
  final Function() onTap;
  const CustomPrimaryTextButton({
    Key? key,
    required this.width,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).colorScheme.primary,
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
