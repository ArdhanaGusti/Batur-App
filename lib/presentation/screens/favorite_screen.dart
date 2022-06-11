import 'package:capstone_design/presentation/components/appbar/custom_sliver_appbar_dashboard.dart';
import 'package:capstone_design/presentation/components/button/custom_primary_text_button.dart';
import 'package:capstone_design/presentation/screens/error_screen.dart';
import 'package:capstone_design/presentation/screens/forgot_password.dart';
import 'package:capstone_design/presentation/screens/login_screen.dart';
import 'package:capstone_design/presentation/screens/on_boarding_screen.dart';
import 'package:capstone_design/presentation/screens/registration_screen.dart';
import 'package:capstone_design/presentation/screens/registration_setting_screen.dart';
import 'package:capstone_design/presentation/screens/reset_password_screen.dart';
import 'package:capstone_design/presentation/screens/verification_screen.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

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
      return Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500.0),
          child: _buildAccountScreen(context, screenSize),
        ),
      );
    } else {
      // Mobile Mode
      return _buildAccountScreen(context, screenSize);
    }
  }

  Widget _buildAccountScreen(BuildContext context, Size screenSize) {
    Brightness screenBrightness = MediaQuery.platformBrightnessOf(context);
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        CustomSliverAppBarDashboard(
          actionIcon: "assets/icon/bell.svg",
          // Must add on Tap
          actionOnTap: () {},
          leading: const Text(
            // Text wait localization
            "Favorite",
            textAlign: TextAlign.center,
          ),
          actionIconSecondary: "",
          // Must add on Tap
          actionOnTapSecondary: () {},
          // Becarefull with this
          isDoubleAction: false,
        ),
        SliverToBoxAdapter(
          child: Column(
            children: <Widget>[
              CustomPrimaryTextButton(
                width: screenSize.width,
                // Text wait localization
                text: 'On Boarding',
                // On tap Navigation needs to be replaced
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OnBoardingScreen(),
                    ),
                  );
                },
              ),
              CustomPrimaryTextButton(
                width: screenSize.width,
                // Text wait localization
                text: 'Login',
                // On tap Navigation needs to be replaced
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
              ),
              CustomPrimaryTextButton(
                width: screenSize.width,
                // Text wait localization
                text: 'Regis',
                // On tap Navigation needs to be replaced
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegistrationScreen(),
                    ),
                  );
                },
              ),
              CustomPrimaryTextButton(
                width: screenSize.width,
                // Text wait localization
                text: 'Regis Setting',
                // On tap Navigation needs to be replaced
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegistrationSettingScreen(),
                    ),
                  );
                },
              ),
              CustomPrimaryTextButton(
                width: screenSize.width,
                // Text wait localization
                text: 'Veriv',
                // On tap Navigation needs to be replaced
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VerificationScreen(),
                    ),
                  );
                },
              ),
              CustomPrimaryTextButton(
                width: screenSize.width,
                // Text wait localization
                text: 'Veriv',
                // On tap Navigation needs to be replaced
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgotPasswordScreen(),
                    ),
                  );
                },
              ),
              CustomPrimaryTextButton(
                width: screenSize.width,
                // Text wait localization
                text: 'Veriv',
                // On tap Navigation needs to be replaced
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ResetPasswordScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
