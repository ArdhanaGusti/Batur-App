import 'package:capstone_design/presentation/bloc/regis_form_bloc.dart';
import 'package:capstone_design/presentation/components/button/custom_multiple_icon_button.dart';
import 'package:capstone_design/presentation/components/button/custom_primary_text_button.dart';
import 'package:capstone_design/presentation/components/textFields/custom_regis_confirm_password_text_field.dart';
import 'package:capstone_design/presentation/components/textFields/custom_regis_email_text_field.dart';
import 'package:capstone_design/presentation/components/textFields/custom_regis_password_text_field.dart';
import 'package:capstone_design/presentation/screens/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:theme/theme.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _regisFormKey = GlobalKey<FormState>();

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
              constraints: const BoxConstraints(maxWidth: 500.0),
              child: _buildRegisScreen(screenSize),
            ),
          ),
        ),
      );
    } else {
      // Mobile Mode
      return Scaffold(
        body: SafeArea(
          child: _buildRegisScreen(screenSize),
        ),
      );
    }
  }

  Widget _buildRegisScreen(Size screenSize) {
    Brightness screenBrightness = MediaQuery.platformBrightnessOf(context);
    // Scaffold must be delete if in dashboard
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              BlocBuilder<ThemeManagerBloc, ThemeManagerState>(
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
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      // Text wait localization
                      'Daftar',
                      style: bHeading3.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    _buildForm(screenSize),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildForm(Size screenSize) {
    return BlocBuilder<RegisFormBloc, RegisFormState>(
      builder: (context, state) {
        return Form(
          key: _regisFormKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: screenSize.height * 0.02,
                ),
                child: const CustomRegisEmailTextField(
                  enable: true,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: screenSize.height * 0.02,
                ),
                child: const CustomRegisPasswordTextField(
                  enable: true,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: screenSize.height * 0.02,
                ),
                child: const CustomRegisConfirmPasswordTextField(),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 30.0,
                  top: 10.0,
                ),
                child: CustomPrimaryTextButton(
                  width: screenSize.width,
                  // Text wait localization
                  text: 'Daftar',
                  // On tap Navigation needs to be replaced
                  onTap: () {
                    Navigator.pop(
                      context,
                    );
                  },
                ),
              ),
              // Text wait localization
              Text(
                "Atau daftar dengan",
                style: bBody2.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 30.0,
                ),
                child: CustomMultipleIconButton(
                  icons: const [
                    "assets/icon/facebook.svg",
                    "assets/icon/twitter.svg",
                    "assets/icon/google.svg",
                  ],
                  onTap: [
                    () {
                      Navigator.pop(
                        context,
                      );
                    },
                    () {
                      Navigator.pop(
                        context,
                      );
                    },
                    () {
                      Navigator.pop(
                        context,
                      );
                    },
                  ],
                  width: (screenSize.width > 500.0)
                      ? (500.0 - 40.0)
                      : (screenSize.width - 40.0),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(
                    context,
                  );
                },
                child: RichText(
                  // Text wait localization
                  text: TextSpan(
                    text: 'Sudah punya akun? ',
                    style: bBody2.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    children: <TextSpan>[
                      // Text wait localization
                      TextSpan(
                        text: 'Masuk',
                        style: bCaption3.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 11.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
