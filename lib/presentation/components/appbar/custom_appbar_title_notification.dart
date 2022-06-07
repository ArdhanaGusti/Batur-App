import 'package:capstone_design/presentation/screens/theme_setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';

class CustomAppBarTitleNotification extends StatelessWidget {
  final String title;
  const CustomAppBarTitleNotification({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 20.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: bHeading4.copyWith(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ThemeSettingScreen(),
                ),
              );
            },
            child: SizedBox(
              height: 40.0,
              width: 40.0,
              child: Center(
                child: SvgPicture.asset(
                  "assets/icon/bell.svg",
                  color: Theme.of(context).colorScheme.tertiary,
                  height: 24.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
