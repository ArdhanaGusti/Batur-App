import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/data/sources/theme_data.dart';

class CustomPrimaryIconTextButton extends StatelessWidget {
  final double width;
  final String text;
  final String icon;
  final Function() onTap;
  const CustomPrimaryIconTextButton({
    Key? key,
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
      label: Text(
        text,
      ),
      icon: SvgPicture.asset(
        icon,
        color: bTextPrimary,
        height: 24.0,
      ),
    );
  }
}
