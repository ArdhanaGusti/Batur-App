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
          (width < 300.0) ? 300.0 : width,
          50.0,
        ),
        maximumSize: Size(
          (width > 500.0) ? 500.0 : width,
          50.0,
        ),
      ),
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}
