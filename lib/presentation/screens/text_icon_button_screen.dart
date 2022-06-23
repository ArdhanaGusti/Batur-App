import 'package:capstone_design/login.dart';
import 'package:capstone_design/presentation/components/custom_text_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme/theme.dart';

class TextIconButtonScreen extends StatelessWidget {
  const TextIconButtonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width - 60;
    Brightness screenBrightness = MediaQuery.platformBrightnessOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Text Icon Button"),
      ),
      body: BlocBuilder<ThemeManagerBloc, ThemeManagerState>(
        builder: (context, state) {
          Color colorOne = (state.isDark == ThemeModeEnum.darkTheme)
              ? bDarkGrey
              : (state.isDark == ThemeModeEnum.lightTheme)
                  ? bPrimary
                  : (screenBrightness == Brightness.light)
                      ? bPrimary
                      : bDarkGrey;
          Color colorTwo = (state.isDark == ThemeModeEnum.darkTheme)
              ? bGrey
              : (state.isDark == ThemeModeEnum.lightTheme)
                  ? bPrimaryVariant1
                  : (screenBrightness == Brightness.light)
                      ? bPrimaryVariant1
                      : bGrey;
          Color colorThree = (state.isDark == ThemeModeEnum.darkTheme)
              ? bGrey
              : (state.isDark == ThemeModeEnum.lightTheme)
                  ? bSecondaryVariant1
                  : (screenBrightness == Brightness.light)
                      ? bSecondaryVariant1
                      : bGrey;
          Color colorFour = (state.isDark == ThemeModeEnum.darkTheme)
              ? bDarkGrey
              : (state.isDark == ThemeModeEnum.lightTheme)
                  ? bSecondary
                  : (screenBrightness == Brightness.light)
                      ? bSecondary
                      : bDarkGrey;
          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: CustomTextIconButton(
                    icon: "assets/icon/upload.svg",
                    color: colorOne,
                    width: width,
                    text: "Upload Gambar",
                    onTap: () {
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: CustomTextIconButton(
                    icon: "assets/icon/map-marker.svg",
                    color: colorTwo,
                    width: width,
                    text: "Petunjuk Arah",
                    onTap: () {
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: CustomTextIconButton(
                    icon: "assets/icon/shopee.svg",
                    color: colorThree,
                    width: width,
                    text: "Shopee",
                    onTap: () {
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: CustomTextIconButton(
                    icon: "assets/icon/tokopedia.svg",
                    color: colorOne,
                    width: width,
                    text: "Tokopedia",
                    onTap: () {
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: CustomTextIconButton(
                    icon: "assets/icon/coupon.svg",
                    color: colorFour,
                    width: width,
                    text: "Dapatkan Tiket",
                    onTap: () {
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ),
                      );
                    },
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
