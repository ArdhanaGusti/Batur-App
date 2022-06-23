import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final bool hamburgerMenu;
  const CustomAppBar(
      {Key? key, required this.title, required this.hamburgerMenu})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Brightness screenBrightness = MediaQuery.platformBrightnessOf(context);
    return BlocBuilder<ThemeManagerBloc, ThemeManagerState>(
      builder: (context, state) {
        bool isLight = (state.isDark == ThemeModeEnum.darkTheme)
            ? false
            : (state.isDark == ThemeModeEnum.lightTheme)
                ? true
                : (screenBrightness == Brightness.light)
                    ? true
                    : false;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: (isLight) ? bLightGrey : bDarkGrey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icon/back.svg",
                    color: (isLight) ? bPrimary : bTextPrimary,
                    height: 24,
                  ),
                ),
              ),
              Text(
                title,
                style: bHeading6.copyWith(
                    color: (isLight) ? bPrimary : bTextPrimary),
              ),
              (hamburgerMenu == true)
                  ? Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: (isLight) ? bLightGrey : bDarkGrey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/icon/map.svg",
                          color: (isLight) ? bPrimary : bTextPrimary,
                          height: 24,
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 40,
                      width: 40,
                    ),
            ],
          ),
        );
      },
    );
  }
}
