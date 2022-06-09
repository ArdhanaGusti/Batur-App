import 'package:capstone_design/presentation/components/appbar/custom_sliver_appbar_dashboard.dart';
import 'package:capstone_design/presentation/screens/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
          leading: BlocBuilder<ThemeManagerBloc, ThemeManagerState>(
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
                height: 30.0,
              );
            },
          ),
          actionIconSecondary: "",
          // Must add on Tap
          actionOnTapSecondary: () {},
          // Becarefull with this
          isDoubleAction: false,
        ),
      ],
    );
  }
}
