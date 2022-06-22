import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';

class CustomIconButton extends StatelessWidget {
  final Color color;
  final double width;
  final bool isLight;
  final String icon;
  final Function() onTap;
  const CustomIconButton({
    Key? key,
    required this.color,
    required this.width,
    required this.isLight,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color),
        overlayColor: (isLight)
            ? MaterialStateProperty.all(bLightGrey)
            : MaterialStateProperty.all(bGrey),
        minimumSize: MaterialStateProperty.all(
          Size(
            (width < 100) ? 100 : width,
            50,
          ),
        ),
        maximumSize: MaterialStateProperty.all(
          Size(
            (width > 500) ? 500 : width,
            50,
          ),
        ),
      ),
      child: (isLight)
          ? SvgPicture.asset(
              icon,
              height: 24,
            )
          : SvgPicture.asset(
              icon,
              color: bTextPrimary,
              height: 24,
            ),
    );
  }
}
