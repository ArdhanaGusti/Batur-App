import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';

class CustomTextIconButton extends StatelessWidget {
  final Color color;
  final double width;
  final String text;
  final String icon;
  final Function() onTap;
  const CustomTextIconButton({
    Key? key,
    required this.color,
    required this.width,
    required this.text,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
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
      icon: SvgPicture.asset(
        icon,
        color: bTextPrimary,
        height: 24,
      ),
      label: Text(
        text,
      ),
    );
  }
}
