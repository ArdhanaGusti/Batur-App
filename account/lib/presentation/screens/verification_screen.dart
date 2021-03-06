import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VerificationScreen extends StatelessWidget {
  VerificationScreen({Key? key}) : super(key: key);
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  final focus4 = FocusNode();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 320.0 || screenSize.height < 650.0) {
      return ErrorScreen(
        title: AppLocalizations.of(context)!.screenError,
        message: AppLocalizations.of(context)!.screenSmall,
      );
    } else if (screenSize.width > 500.0) {
      // Tablet Mode (Must be repair)
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500.0),
              child: _buildVerificationScreen(context, screenSize),
            ),
          ),
        ),
      );
    } else {
      // Mobile Mode
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: _buildVerificationScreen(context, screenSize),
        ),
      );
    }
  }

  Widget _buildVerificationScreen(BuildContext context, Size screenSize) {
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
                title: AppLocalizations.of(context)!.verification,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: screenSize.height * 0.05,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icon/regular/envelope.svg",
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
                  child: Text(
                    AppLocalizations.of(context)!.verificationDesc,
                    style: bSubtitle1.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: screenSize.height * 0.05,
                ),
                child: Center(
                  child: Form(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomVerificationTextField(
                          focusNow: focus1,
                          focusNext: focus2,
                          field: 1,
                        ),
                        CustomVerificationTextField(
                          focusNow: focus2,
                          focusNext: focus3,
                          field: 2,
                        ),
                        CustomVerificationTextField(
                          focusNow: focus3,
                          focusNext: focus4,
                          field: 3,
                        ),
                        CustomVerificationTextField(
                          focusNow: focus4,
                          focusNext: focus4,
                          field: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenSize.height * 0.02),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.didnVerification,
                    style: bSubtitle1.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenSize.height * 0.01),
                child: Center(
                  child: GestureDetector(
                    // On tap must be replace
                    onTap: () {},

                    child: Text(
                      AppLocalizations.of(context)!.sendBackVerification,
                      style: bSubtitle3.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
          CustomPrimaryTextButton(
            width: screenSize.width,
            text: AppLocalizations.of(context)!.verification,
            onTap: () {
              // On tap must be replace
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const DashboardScreen(),
              //   ),
              // );
            },
          ),
        ],
      ),
    );
  }
}
