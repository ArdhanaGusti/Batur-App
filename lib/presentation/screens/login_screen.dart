import 'package:capstone_design/presentation/bloc/login_form_bloc.dart';
import 'package:capstone_design/presentation/components/custom_icon_button.dart';
import 'package:capstone_design/presentation/components/custom_text_button.dart';
import 'package:capstone_design/presentation/components/textFields/custom_login_password_text_field.dart';
import 'package:capstone_design/presentation/components/textFields/custom_login_username_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme/theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();

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
        // Delete Scaffold because, this page use in dashboard
        return BlocProvider(
          create: (context) => LoginFormBloc(),
          child: Scaffold(
            body: SafeArea(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: BlocBuilder<LoginFormBloc, LoginFormState>(
                      builder: (context, state) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Image.asset(
                              (isLight)
                                  ? 'assets/logo/logo.png'
                                  : 'assets/logo/logo_dark.png',
                              height: 40.0,
                            ),
                            SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      // Text wait localization
                                      'Masuk',
                                      style: bHeading3.copyWith(
                                        color:
                                            (isLight) ? bPrimary : bTextPrimary,
                                      ),
                                    ),
                                    Form(
                                      key: _loginFormKey,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 20.0,
                                            ),
                                            child: CustomLoginUsernameTextField(
                                              isLight: isLight,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                CustomLoginPasswordTextField(
                                                    isLight: isLight),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      print(
                                                          "Ke halaman lupa password");
                                                    },
                                                    child: Text(
                                                      "Lupa Password ?",
                                                      style:
                                                          bSubtitle2.copyWith(
                                                        color: (isLight)
                                                            ? bPrimary
                                                            : bTextPrimary,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (() => context
                                                .read<LoginFormBloc>()
                                                .add(
                                                  LoginFormRememberMeChanged(
                                                    rememberMe:
                                                        !state.rememberMe,
                                                  ),
                                                )),
                                            child: Row(
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 24.0,
                                                  width: 24.0,
                                                  child: Checkbox(
                                                    side: BorderSide(
                                                      width: 1.0,
                                                      color: (isLight)
                                                          ? bPrimary
                                                          : bGrey,
                                                    ),
                                                    activeColor: (isLight)
                                                        ? bPrimary
                                                        : bGrey,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    value: state.rememberMe,
                                                    onChanged: (value) =>
                                                        context
                                                            .read<
                                                                LoginFormBloc>()
                                                            .add(
                                                              LoginFormRememberMeChanged(
                                                                rememberMe:
                                                                    value!,
                                                              ),
                                                            ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text(
                                                  "Remember me",
                                                  style: bBody1.copyWith(
                                                    color: (isLight)
                                                        ? bPrimaryVariant1
                                                        : bTextPrimary,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 30.0,
                                              top: 10.0,
                                            ),
                                            child: CustomTextButton(
                                              color: (isLight)
                                                  ? bPrimary
                                                  : bDarkGrey,
                                              width: screenSize.width,
                                              // Text wait localization
                                              text: 'Masuk',
                                              // On tap Navigation needs to be replaced
                                              onTap: () {
                                                Navigator.pop(
                                                  context,
                                                );
                                              },
                                            ),
                                          ),
                                          Text(
                                            "Atau masuk dengan",
                                            style: bBody2.copyWith(
                                                color: (isLight)
                                                    ? bPrimary
                                                    : bTextPrimary),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 30.0,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CustomIconButton(
                                                  icon:
                                                      "assets/icon/facebook.svg",
                                                  color: (isLight)
                                                      ? bTextPrimary
                                                      : bDarkGrey,
                                                  width:
                                                      (screenSize.width - 70) /
                                                          3,
                                                  isLight: isLight,
                                                  onTap: () {
                                                    Navigator.pop(
                                                      context,
                                                    );
                                                  },
                                                ),
                                                CustomIconButton(
                                                  icon:
                                                      "assets/icon/twitter.svg",
                                                  color: (isLight)
                                                      ? bTextPrimary
                                                      : bDarkGrey,
                                                  width:
                                                      (screenSize.width - 70) /
                                                          3,
                                                  isLight: isLight,
                                                  onTap: () {
                                                    Navigator.pop(
                                                      context,
                                                    );
                                                  },
                                                ),
                                                CustomIconButton(
                                                  icon:
                                                      "assets/icon/google.svg",
                                                  color: (isLight)
                                                      ? bTextPrimary
                                                      : bDarkGrey,
                                                  width:
                                                      (screenSize.width - 70) /
                                                          3,
                                                  isLight: isLight,
                                                  onTap: () {
                                                    Navigator.pop(
                                                      context,
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              print("Page daftar");
                                            },
                                            child: RichText(
                                              text: TextSpan(
                                                text: 'Belum punya akun? ',
                                                style: bBody2.copyWith(
                                                    color: (isLight)
                                                        ? bPrimary
                                                        : bTextPrimary),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: 'Daftar',
                                                    style: bCaption3.copyWith(
                                                      color: (isLight)
                                                          ? bPrimary
                                                          : bTextPrimary,
                                                      fontSize: 11.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
