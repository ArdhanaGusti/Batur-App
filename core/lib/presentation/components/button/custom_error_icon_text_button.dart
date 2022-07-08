import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/data/sources/theme_data.dart';

// Review Check 1 (Done)

class CustomErrorIconTextButton extends StatelessWidget {
  final double width;
  final String text;
  final String icon;
  final Function() onTap;
  const CustomErrorIconTextButton({
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
        primary: bError,
        minimumSize: Size(
          (width < 300.0) ? 300.0 : width,
          50.0,
        ),
        maximumSize: Size(
          (width > 500.0) ? 500.0 : width,
          50.0,
        ),
      ),
      label: Text(
        text,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      icon: SvgPicture.asset(
        icon,
        color: bTextPrimary,
        height: 24.0,
      ),
    );
  }
}
