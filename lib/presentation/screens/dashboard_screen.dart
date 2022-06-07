import 'dart:async';

import 'package:capstone_design/presentation/screens/account_screen.dart';
import 'package:capstone_design/presentation/screens/favorite_screen.dart';
import 'package:capstone_design/presentation/screens/home_screen.dart';
import 'package:capstone_design/presentation/screens/news_screen.dart';
import 'package:capstone_design/presentation/screens/theme_setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  static const String _homeTitle = 'Beranda';
  static const String _newsTitle = 'Berita';
  static const String _favoriteTitle = 'Favorite';
  static const String _accountTitle = 'Akun';

  final List<Widget> _listWidget = [
    const HomeScreen(),
    const NewsScreen(),
    const FavoriteScreen(),
    const AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_selectedIndex],
      bottomNavigationBar: BlocBuilder<ThemeManagerBloc, ThemeManagerState>(
        builder: (context, state) {
          Brightness screenBrightness =
              MediaQuery.platformBrightnessOf(context);
          Color activeBottomNav = (state.isDark == ThemeModeEnum.darkTheme)
              ? bTextPrimary
              : (state.isDark == ThemeModeEnum.lightTheme)
                  ? bPrimary
                  : (screenBrightness == Brightness.light)
                      ? bPrimary
                      : bTextPrimary;
          Color backgroundBottomNav = (state.isDark == ThemeModeEnum.darkTheme)
              ? bDarkGrey
              : (state.isDark == ThemeModeEnum.lightTheme)
                  ? bTextPrimary
                  : (screenBrightness == Brightness.light)
                      ? bTextPrimary
                      : bDarkGrey;
          return BottomNavigationBar(
            backgroundColor: backgroundBottomNav,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/icon/home_outline.svg",
                  color: bGrey,
                  height: 24,
                ),
                activeIcon: SvgPicture.asset(
                  "assets/icon/home.svg",
                  color: activeBottomNav,
                  height: 24,
                ),
                label: _homeTitle,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/icon/copy_outline.svg",
                  color: bGrey,
                  height: 24,
                ),
                activeIcon: SvgPicture.asset(
                  "assets/icon/copy.svg",
                  color: activeBottomNav,
                  height: 24,
                ),
                label: _newsTitle,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/icon/star_outline.svg",
                  color: bGrey,
                  height: 24,
                ),
                activeIcon: SvgPicture.asset(
                  "assets/icon/star.svg",
                  color: activeBottomNav,
                  height: 24,
                ),
                label: _favoriteTitle,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/icon/user_outline.svg",
                  color: bGrey,
                  height: 24,
                ),
                activeIcon: SvgPicture.asset(
                  "assets/icon/user.svg",
                  color: activeBottomNav,
                  height: 24,
                ),
                label: _accountTitle,
              ),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedFontSize: 10,
            selectedLabelStyle: bCaption3.copyWith(color: activeBottomNav),
            unselectedFontSize: 10,
            unselectedLabelStyle: bCaption1.copyWith(color: bGrey),
            selectedItemColor: activeBottomNav,
            unselectedItemColor: bGrey,
          );
        },
      ),
    );
  }
}
