import 'package:capstone_design/login.dart';
import 'package:capstone_design/presentation/components/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme/theme.dart';

class IconButtonScreen extends StatelessWidget {
  const IconButtonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width - 90;
    Brightness screenBrightness = MediaQuery.platformBrightnessOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Icon Button"),
      ),
      body: BlocBuilder<ThemeManagerBloc, ThemeManagerState>(
        builder: (context, state) {
          Color colorOne = (state.isDark == ThemeModeEnum.darkTheme)
              ? bDarkGrey
              : (state.isDark == ThemeModeEnum.lightTheme)
                  ? bTextPrimary
                  : (screenBrightness == Brightness.light)
                      ? bTextPrimary
                      : bDarkGrey;
          Color colorTwo = (state.isDark == ThemeModeEnum.darkTheme)
              ? bGrey
              : (state.isDark == ThemeModeEnum.lightTheme)
                  ? bLightGrey
                  : (screenBrightness == Brightness.light)
                      ? bLightGrey
                      : bGrey;
          bool isLight = (state.isDark == ThemeModeEnum.darkTheme)
              ? false
              : (state.isDark == ThemeModeEnum.lightTheme)
                  ? true
                  : (screenBrightness == Brightness.light)
                      ? true
                      : false;
          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomIconButton(
                        icon: "assets/icon/facebook.svg",
                        color: colorOne,
                        width: width / 3,
                        isLight: isLight,
                        onTap: () {
                          Navigator.pop(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                        },
                      ),
                      CustomIconButton(
                        icon: "assets/icon/twitter.svg",
                        color: colorOne,
                        width: width / 3,
                        isLight: isLight,
                        onTap: () {
                          Navigator.pop(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                        },
                      ),
                      CustomIconButton(
                        icon: "assets/icon/google.svg",
                        color: colorOne,
                        width: width / 3,
                        isLight: isLight,
                        onTap: () {
                          Navigator.pop(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomIconButton(
                        icon: "assets/icon/facebook.svg",
                        color: colorTwo,
                        width: width / 3,
                        isLight: isLight,
                        onTap: () {
                          Navigator.pop(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                        },
                      ),
                      CustomIconButton(
                        icon: "assets/icon/twitter.svg",
                        color: colorTwo,
                        width: width / 3,
                        isLight: isLight,
                        onTap: () {
                          Navigator.pop(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                        },
                      ),
                      CustomIconButton(
                        icon: "assets/icon/google.svg",
                        color: colorTwo,
                        width: width / 3,
                        isLight: isLight,
                        onTap: () {
                          Navigator.pop(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomIconButton(
                        icon: "assets/icon/facebook.svg",
                        color: colorOne,
                        width: width / 2,
                        isLight: isLight,
                        onTap: () {
                          Navigator.pop(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                        },
                      ),
                      CustomIconButton(
                        icon: "assets/icon/twitter.svg",
                        color: colorOne,
                        width: width / 2,
                        isLight: isLight,
                        onTap: () {
                          Navigator.pop(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomIconButton(
                        icon: "assets/icon/facebook.svg",
                        color: colorTwo,
                        width: width + 30,
                        isLight: isLight,
                        onTap: () {
                          Navigator.pop(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
