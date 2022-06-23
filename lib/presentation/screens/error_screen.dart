import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';

class ErrorScreen extends StatelessWidget {
  final String title;
  final String message;
  const ErrorScreen({
    Key? key,
    required this.title,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
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
        if (screenSize.width > 500) {
          // Tablet Mode
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: _errorScreen(context, isLight, screenSize),
                ),
              ),
            ),
          );
        } else {
          // Mobile Mode
          return Scaffold(
            body: SafeArea(
              child: _errorScreen(context, isLight, screenSize),
            ),
          );
        }
        // Is the tablet viewport included ?
      },
    );
  }

  Widget _errorScreen(BuildContext context, bool isLight, Size screenSize) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              _appBar(context, isLight),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text wait localization
                      Text(
                        title,
                        style: bHeading3.copyWith(
                          color: (isLight) ? bPrimary : bTextPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50.0),
                        child: SvgPicture.asset(
                          'assets/image/404.svg',
                          width: screenSize.width * 0.7,
                        ),
                      ),
                      // Text wait localization
                      Text(
                        message,
                        style: bHeading6.copyWith(
                          color: (isLight) ? bPrimary : bTextPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context, bool isLight) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          (isLight) ? 'assets/logo/logo.png' : 'assets/logo/logo_dark.png',
          height: 30.0,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(
              context,
            );
          },
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: (isLight) ? bLightGrey : bDarkGrey,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: SvgPicture.asset(
                "assets/icon/cross.svg",
                color: (isLight) ? bPrimary : bTextPrimary,
                height: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
