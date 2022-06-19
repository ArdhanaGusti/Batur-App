import 'dart:async';

import 'package:capstone_design/presentation/screens/account_screen.dart';
import 'package:capstone_design/presentation/screens/favorite_screen.dart';
import 'package:capstone_design/presentation/screens/home_screen.dart';
import 'package:capstone_design/presentation/screens/login_screen.dart';
import 'package:capstone_design/presentation/screens/news_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:theme/theme.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  // Change with shared preferences
  bool isLogin = true;

  // Wait Localization
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
      if (index == 2 || index == 3) {
        if (isLogin) {
          _selectedIndex = index;
        } else {
          Navigator.push(
            context,
            PageTransition(
              curve: Curves.easeOutCirc,
              type: PageTransitionType.bottomToTop,
              child: const LoginScreen(),
              duration: const Duration(milliseconds: 250),
              reverseDuration: const Duration(milliseconds: 250),
            ),
          );
        }
      } else {
        _selectedIndex = index;
      }
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
          return BottomNavigationBar(
            items: [
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
                label: _homeTitle,
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
                label: _newsTitle,
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
                label: _favoriteTitle,
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
                label: _accountTitle,
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedFontSize: 10.0,
            unselectedFontSize: 10.0,
          );
        },
      ),
    );
  }
}
