import 'package:capstone_design/presentation/bloc/regis_form_bloc.dart';
import 'package:capstone_design/presentation/components/custom_icon_button.dart';
import 'package:capstone_design/presentation/components/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        return Scaffold(
          body: SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        (isLight)
                            ? 'assets/logo/logo.png'
                            : 'assets/logo/logo_dark.png',
                        height: 40.0,
                      ),
                      BlocBuilder<RegisFormBloc, RegisFormState>(
                        builder: (context, state) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  // Text wait localization
                                  'Daftar',
                                  style: bHeading3.copyWith(
                                    color: (isLight) ? bPrimary : bTextPrimary,
                                  ),
                                ),
                                Form(
                                  key: _regisFormKey,
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 20.0,
                                        ),
                                        child: TextFormField(
                                          style: bSubtitle1.copyWith(
                                              color: (isLight)
                                                  ? bPrimary
                                                  : bTextPrimary),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          initialValue: state.email,
                                          decoration: InputDecoration(
                                            labelText: "Email",
                                            errorStyle: bCaption1.copyWith(
                                                color: bError),
                                            hintText: "Batur@gmail.com",
                                            prefixIcon: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 20.0,
                                                right: 15.0,
                                              ),
                                              child: SvgPicture.asset(
                                                "assets/icon/envelope.svg",
                                                color: (isLight)
                                                    ? bPrimary
                                                    : bTextPrimary,
                                                height: 24,
                                              ),
                                            ),
                                          ),
                                          validator: (text) {
                                            if (text == null || text.isEmpty) {
                                              return 'Please enter some text';
                                            }
                                            return null;
                                          },
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          onChanged: (text) {
                                            context.read<RegisFormBloc>().add(
                                                  RegisFormEmailChanged(
                                                    email: text,
                                                  ),
                                                );
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 20.0,
                                        ),
                                        child: TextFormField(
                                          obscureText: state.obsecurePassword,
                                          initialValue: state.password,
                                          style: bSubtitle1.copyWith(
                                              color: (isLight)
                                                  ? bPrimary
                                                  : bTextPrimary),
                                          decoration: InputDecoration(
                                            labelText: "Password",
                                            errorStyle: bCaption1.copyWith(
                                                color: bError),
                                            suffixIcon: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0, right: 20.0),
                                              child: GestureDetector(
                                                onTap: (() => context
                                                    .read<RegisFormBloc>()
                                                    .add(
                                                      RegisFormObsecurePasswordChanged(
                                                        obsecure: !state
                                                            .obsecurePassword,
                                                      ),
                                                    )),
                                                child: SvgPicture.asset(
                                                  (state.obsecurePassword)
                                                      ? "assets/icon/eye.svg"
                                                      : "assets/icon/eye-slash.svg",
                                                  color: (isLight)
                                                      ? bPrimary
                                                      : bTextPrimary,
                                                  height: 24,
                                                ),
                                              ),
                                            ),
                                            prefixIcon: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 20.0,
                                                right: 15.0,
                                              ),
                                              child: SvgPicture.asset(
                                                "assets/icon/lock.svg",
                                                color: (isLight)
                                                    ? bPrimary
                                                    : bTextPrimary,
                                                height: 24,
                                              ),
                                            ),
                                          ),
                                          validator: (text) {
                                            if (text == null || text.isEmpty) {
                                              return 'Please enter some text';
                                            } else if (text.length < 7) {
                                              return 'Length must be min 8 char';
                                            }
                                            return null;
                                          },
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          onChanged: (text) {
                                            context.read<RegisFormBloc>().add(
                                                  RegisFormPasswordChanged(
                                                    password: text,
                                                  ),
                                                );
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 20.0,
                                        ),
                                        child: TextFormField(
                                          initialValue: state.passwordConf,
                                          obscureText:
                                              state.obsecurePasswordConf,
                                          style: bSubtitle1.copyWith(
                                              color: (isLight)
                                                  ? bPrimary
                                                  : bTextPrimary),
                                          decoration: InputDecoration(
                                            labelText: "Password Confirmation",
                                            errorStyle: bCaption1.copyWith(
                                                color: bError),
                                            suffixIcon: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0, right: 20.0),
                                              child: GestureDetector(
                                                onTap: (() => context
                                                    .read<RegisFormBloc>()
                                                    .add(
                                                      RegisFormObsecurePasswordConfChanged(
                                                        obsecureConf: !state
                                                            .obsecurePasswordConf,
                                                      ),
                                                    )),
                                                child: SvgPicture.asset(
                                                  (state.obsecurePasswordConf)
                                                      ? "assets/icon/eye.svg"
                                                      : "assets/icon/eye-slash.svg",
                                                  color: (isLight)
                                                      ? bPrimary
                                                      : bTextPrimary,
                                                  height: 24,
                                                ),
                                              ),
                                            ),
                                            prefixIcon: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 20.0,
                                                right: 15.0,
                                              ),
                                              child: SvgPicture.asset(
                                                "assets/icon/lock.svg",
                                                color: (isLight)
                                                    ? bPrimary
                                                    : bTextPrimary,
                                                height: 24,
                                              ),
                                            ),
                                          ),
                                          validator: (text) {
                                            if (text == null || text.isEmpty) {
                                              return 'Please enter some text';
                                            } else if (text.length < 7) {
                                              return 'Length must be min 8 char';
                                            }
                                            return null;
                                          },
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          onChanged: (text) {
                                            context.read<RegisFormBloc>().add(
                                                  RegisFormPasswordConfChanged(
                                                    passwordConf: text,
                                                  ),
                                                );
                                          },
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
                                    color: (isLight) ? bPrimary : bDarkGrey,
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
                                Center(
                                  child: Text(
                                    "Atau daftar dengan",
                                    style: bBody2.copyWith(
                                        color: (isLight)
                                            ? bPrimary
                                            : bTextPrimary),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 30.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomIconButton(
                                        icon: "assets/icon/facebook.svg",
                                        color: (isLight)
                                            ? bTextPrimary
                                            : bDarkGrey,
                                        width: (screenSize.width - 70) / 3,
                                        isLight: isLight,
                                        onTap: () {
                                          Navigator.pop(
                                            context,
                                          );
                                        },
                                      ),
                                      CustomIconButton(
                                        icon: "assets/icon/twitter.svg",
                                        color: (isLight)
                                            ? bTextPrimary
                                            : bDarkGrey,
                                        width: (screenSize.width - 70) / 3,
                                        isLight: isLight,
                                        onTap: () {
                                          Navigator.pop(
                                            context,
                                          );
                                        },
                                      ),
                                      CustomIconButton(
                                        icon: "assets/icon/google.svg",
                                        color: (isLight)
                                            ? bTextPrimary
                                            : bDarkGrey,
                                        width: (screenSize.width - 70) / 3,
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
                                Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      print("Page daftar");
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Sudah punya akun? ',
                                        style: bBody2.copyWith(
                                            color: (isLight)
                                                ? bPrimary
                                                : bTextPrimary),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Masuk',
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
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
