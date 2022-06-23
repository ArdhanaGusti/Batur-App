import 'package:core/core.dart';
import 'package:core/presentation/screens/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:theme/theme.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 320.0 || screenSize.height < 650.0) {
      return const ErrorScreen(
        // Text wait localization
        title: "AppLocalizations.of(context)!.screenError",
        message: "AppLocalizations.of(context)!.screenSmall",
      );
    } else if (screenSize.width > 500.0) {
      // Tablet Mode (Must be repair)
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500.0),
              child: _buildResetPasswordScreen(context, screenSize),
            ),
          ),
        ),
      );
    } else {
      // Mobile Mode
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: _buildResetPasswordScreen(context, screenSize),
        ),
      );
    }
  }

  Widget _buildResetPasswordScreen(BuildContext context, Size screenSize) {
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
                title: "AppLocalizations.of(context)!.resetPassword",
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: screenSize.height * 0.05,
                ),
                child: Center(
                  // Text wait localization
                  child: Text(
                    "AppLocalizations.of(context)!.accountIsVerified",
                    style: bSubtitle1.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: screenSize.height * 0.01,
                  bottom: screenSize.height * 0.05,
                ),
                child: Center(
                  // Text wait localization
                  child: Text(
                    "AppLocalizations.of(context)!.enterNewPassword",
                    style: bSubtitle1.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: screenSize.height * 0.02,
                ),
                child: const CustomForgotPasswordPasswordTextField(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: screenSize.height * 0.02,
                ),
                child: const CustomForgotPasswordConfirmPasswordTextField(),
              ),
            ],
          ),
          CustomPrimaryTextButton(
            width: screenSize.width,
            // Text wait localization
            text: "AppLocalizations.of(context)!.done",
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
