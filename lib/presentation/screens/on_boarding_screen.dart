import 'dart:async';

import 'package:capstone_design/presentation/components/button/custom_primary_text_button.dart';
import 'package:capstone_design/presentation/screens/dashboard_screen.dart';
import 'package:capstone_design/presentation/screens/error_screen.dart';
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
    if (screenSize.width < 320.0 || screenSize.height < 650.0) {
      return const ErrorScreen(
        // Text wait localization
        title: "Error Layar",
        message: "Aduh, Layar anda terlalu kecil",
      );
    } else if (screenSize.width > 500.0) {
      // Tablet Mode (Must be repair)
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500),
              child: _buildOnBoardingScreen(screenSize),
            ),
          ),
        ),
      );
    } else {
      // Mobile Mode
      return Scaffold(
        body: SafeArea(
          child: _buildOnBoardingScreen(screenSize),
        ),
      );
    }
  }

  Widget _buildOnBoardingScreen(Size screenSize) {
    Brightness screenBrightness = MediaQuery.platformBrightnessOf(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: <Widget>[
              Center(
                child: BlocBuilder<ThemeManagerBloc, ThemeManagerState>(
                  builder: (context, state) {
                    bool isLight = (state.isDark == ThemeModeEnum.darkTheme)
                        ? false
                        : (state.isDark == ThemeModeEnum.lightTheme)
                            ? true
                            : (screenBrightness == Brightness.light)
                                ? true
                                : false;
                    return Image.asset(
                      (isLight)
                          ? 'assets/logo/logo.png'
                          : 'assets/logo/logo_dark.png',
                      height: 40.0,
                    );
                  },
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
                      color: Theme.of(context).colorScheme.tertiary,
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
                    'Jelajahi seluruh kota bandung dalam satu gengaman dan ciptakan momen indah Anda bersama keluarga dan teman-teman Anda dengan aplikasi Bandung Tourism',
                    style: bSubtitle1.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          CustomPrimaryTextButton(
            width: screenSize.width,
            // Text wait localization
            text: 'Mulai Sekarang',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const DashboardScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
