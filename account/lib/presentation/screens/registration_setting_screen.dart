import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';

class RegistrationSettingScreen extends StatelessWidget {
  const RegistrationSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 320.0 || screenSize.height < 720.0) {
      return const ErrorScreen(
        // Text wait localization"
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
              child: _buildRegistrationSettingForm(context, screenSize),
            ),
          ),
        ),
      );
    } else {
      // Mobile Mode
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: _buildRegistrationSettingForm(context, screenSize),
        ),
      );
    }
  }

  Widget _buildRegistrationSettingForm(BuildContext context, Size screenSize) {
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
                title: "AppLocalizations.of(context)!.accountSettings",
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: screenSize.height * 0.05,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image.asset(
                    "assets/image/profile.jpg",
                    height: 100.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenSize.height * 0.03),
                child: GestureDetector(
                  // On tap Navigation needs to be replaced
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(
                        "assets/icon/pen.svg",
                        color: Theme.of(context).colorScheme.tertiary,
                        height: 24.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "AppLocalizations.of(context)!.editProfile",
                          style: bSubtitle1.copyWith(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: screenSize.height * 0.03,
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: screenSize.height * 0.01,
                      ),
                      child: const CustomRegisEmailTextField(
                        enable: false,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: screenSize.height * 0.01,
                      ),
                      child: const CustomRegisUsernameTextField(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: screenSize.height * 0.01,
                      ),
                      child: const CustomRegisFullNameTextField(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: screenSize.height * 0.01,
                      ),
                      child: const CustomRegisPasswordTextField(
                        enable: false,
                      ),
                    ),
                  ],
                ),
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
