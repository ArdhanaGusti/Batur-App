import 'dart:async';

import 'package:capstone_design/login.dart';
import 'package:capstone_design/presentation/components/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:theme/theme.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    Brightness screenBrightness = MediaQuery.platformBrightnessOf(context);
    if (screenSize.width < 320 || screenSize.height < 650) {
      // Error page
      return const Scaffold(
        body: Center(
          child: Text("404 Error"),
        ),
      );
    } else if (screenSize.width > 500) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500),
              child: _buildOnBoardingScreen(screenSize, screenBrightness),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: SafeArea(
          child: _buildOnBoardingScreen(screenSize, screenBrightness),
        ),
      );
    }
    // Is the tablet viewport included
  }

  Widget _buildOnBoardingScreen(Size screenSize, Brightness screenBrightness) {
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
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: <Widget>[
                  Center(
                    child: Image.asset(
                      (isLight)
                          ? 'assets/logo/logo.png'
                          : 'assets/logo/logo_dark.png',
                      height: 40.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenSize.height * 0.01),
                    child: Center(
                      child: Image.asset(
                        'assets/image/gedung_sate.png',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenSize.height * 0.01),
                    child: Center(
                      // Text wait localization
                      child: Text(
                        'Jelajahi Bandung',
                        style: bHeading3.copyWith(
                          color: (isLight) ? bPrimary : bTextPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenSize.height * 0.05),
                    child: Center(
                      // Text wait localization
                      child: Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s.',
                        style: bSubtitle1.copyWith(
                          color: (isLight) ? bPrimary : bTextPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              CustomTextButton(
                color: (isLight) ? bPrimary : bDarkGrey,
                width: screenSize.width,
                // Text wait localization
                text: 'Mulai Sekarang',
                // On tap Navigation needs to be replaced
                onTap: () {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
