import 'dart:async';

import 'package:core/presentation/bloc/dashboard_bloc.dart';
import 'package:core/presentation/screens/account_screen.dart';
import 'package:core/presentation/screens/favorite_screen.dart';
import 'package:core/presentation/screens/home_screen.dart';
import 'package:core/presentation/screens/news_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';

// Check

class DashboardScreen extends StatefulWidget {
  // Add parameter from Main
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Change with shared preferences (Delete if parameter Added)
  bool isLogin = true;

  final List<Widget> _listWidget = [
    const HomeScreen(),
    const NewsScreen(),
    const FavoriteScreen(),
    const AccountScreen(),
  ];

  void _bottomNavIndexChange(int index) {
    if (index == 2 || index == 3) {
      if (isLogin) {
        context.read<DashboardBloc>().add(
              IndexBottomNavChange(newIndex: index),
            );
      } else {
        // Change to login screen
        print("Not Login");
      }
    } else {
      context.read<DashboardBloc>().add(
            IndexBottomNavChange(newIndex: index),
          );
    }
  }

  @override
  void initState() {
    super.initState();
    // Change with to fetch data
    Timer(const Duration(seconds: 1), () {
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, bottomNav) {
        return Scaffold(
          body: _listWidget[bottomNav.indexBottomNav],
          bottomNavigationBar: BlocBuilder<ThemeManagerBloc, ThemeManagerState>(
            builder: (context, theme) {
              Brightness screenBrightness =
                  MediaQuery.platformBrightnessOf(context);
              Color activeBottomNav = (theme.isDark == ThemeModeEnum.darkTheme)
                  ? bTextPrimary
                  : (theme.isDark == ThemeModeEnum.lightTheme)
                      ? bPrimary
                      : (screenBrightness == Brightness.light)
                          ? bPrimary
                          : bTextPrimary;
              return BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/icon/light/home.svg",
                      color: bGrey,
                      height: 24.0,
                    ),
                    activeIcon: SvgPicture.asset(
                      "assets/icon/fill/home.svg",
                      color: activeBottomNav,
                      height: 24.0,
                    ),
                    // Wait Localization
                    label: "Beranda",
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/icon/light/copy.svg",
                      color: bGrey,
                      height: 24.0,
                    ),
                    activeIcon: SvgPicture.asset(
                      "assets/icon/fill/copy.svg",
                      color: activeBottomNav,
                      height: 24.0,
                    ),
                    // Wait Localization
                    label: "Berita",
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/icon/light/star.svg",
                      color: bGrey,
                      height: 24.0,
                    ),
                    activeIcon: SvgPicture.asset(
                      "assets/icon/fill/star.svg",
                      color: activeBottomNav,
                      height: 24.0,
                    ),
                    // Wait Localization
                    label: "Favorite",
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/icon/light/user.svg",
                      color: bGrey,
                      height: 24.0,
                    ),
                    activeIcon: SvgPicture.asset(
                      "assets/icon/fill/user.svg",
                      color: activeBottomNav,
                      height: 24.0,
                    ),
                    // Wait Localization
                    label: "Akun",
                  ),
                ],
                currentIndex: bottomNav.indexBottomNav,
                onTap: _bottomNavIndexChange,
                selectedFontSize: 10.0,
                unselectedFontSize: 10.0,
              );
            },
          ),
        );
      },
    );
  }
}
