import 'package:capstone_design/presentation/components/appbar/custom_appbar.dart';
import 'package:capstone_design/presentation/components/button/custom_primary_text_button.dart';
import 'package:capstone_design/presentation/components/textFields/custom_forgot_password_email_text_field.dart';
import 'package:capstone_design/presentation/screens/dashboard_screen.dart';
import 'package:capstone_design/presentation/screens/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

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
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500.0),
              child: _buildForgotPasswordScreen(context, screenSize),
            ),
          ),
        ),
      );
    } else {
      // Mobile Mode
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: _buildForgotPasswordScreen(context, screenSize),
        ),
      );
    }
  }

  Widget _buildForgotPasswordScreen(BuildContext context, Size screenSize) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              CustomAppBarLeadingBack(
                onTap: () {
                  Navigator.pop(
                    context,
                  );
                },
                // Text wait localization
                title: "Lupa Password",
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: screenSize.height * 0.05,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icon/shield.svg",
                    color: Theme.of(context).colorScheme.tertiary,
                    height: 100.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: screenSize.height * 0.05,
                ),
                child: Center(
                  // Text wait localization
                  child: Text(
                    'Lupa Password? Tidak perlu khawatir, Masukkan Email anda disini',
                    style: bSubtitle1.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: screenSize.height * 0.05,
                ),
                child: const CustomForgotPasswordEmailTextField(
                  enable: true,
                ),
              ),
            ],
          ),
          CustomPrimaryTextButton(
            width: screenSize.width,
            // Text wait localization
            text: 'Lanjut',
            onTap: () {
              // On tap must be replace
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
