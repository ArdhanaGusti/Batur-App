import 'dart:async';

import 'package:capstone_design/presentation/components/button/custom_primary_text_button.dart';
import 'package:capstone_design/presentation/screens/dashboard_screen.dart';
import 'package:capstone_design/presentation/screens/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:page_transition/page_transition.dart';
import 'package:theme/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Review Check 1 (Done)

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

    if (screenSize.width < 320.0 || screenSize.height < 600.0) {
      return ErrorScreen(
        // Text wait localization
        title: AppLocalizations.of(context)!.internetConnection,
        message: AppLocalizations.of(context)!.screenSmall,
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
        children: <Widget>[
          Column(
            children: <Widget>[
              Center(
                child: BlocBuilder<ThemeManagerBloc, ThemeManagerState>(
                  builder: (context, theme) {
                    bool isLight = (theme.isDark == ThemeModeEnum.darkTheme)
                        ? false
                        : (theme.isDark == ThemeModeEnum.lightTheme)
                            ? true
                            : (screenBrightness == Brightness.light)
                                ? true
                                : false;
                    return Image.asset(
                      (isLight)
                          ? "assets/logo/logo.png"
                          : "assets/logo/logo_dark.png",
                      height: 40.0,
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenSize.height * 0.01),
                child: Center(
                  child: Image.asset(
                    "assets/image/gedung_sate.png",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenSize.height * 0.005),
                child: Center(
                  // Text wait localization
                  child: Text(
                    AppLocalizations.of(context)!.onBoardingScreenTitle,
                    style: bHeading3.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenSize.height * 0.03),
                child: Center(
                  // Text wait localization
                  child: Text(
                    AppLocalizations.of(context)!.onBoardingScreenDesc,
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
            text: AppLocalizations.of(context)!.btnStartNow,
            onTap: () {
              Navigator.pushReplacement(
                context,
                PageTransition(
                  type: PageTransitionType.scale,
                  // Paramater in Dashboard
                  child: const DashboardScreen(),
                  alignment: Alignment.center,
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 850),
                  reverseDuration: const Duration(milliseconds: 850),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
