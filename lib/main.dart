import 'dart:async';

import 'package:account/account.dart';
import 'package:core/core.dart';
import 'package:core/presentation/bloc/dashboard_bloc.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme/presentation/injection/theme_injection.dart' as ti;
import 'package:capstone_design/injection.dart' as di;
import 'package:theme/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:transportation/transportation.dart';

void main() async {
  ti.init();
  di.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ti.locator<ThemeManagerBloc>(),
        ),
        BlocProvider(
          create: (context) => DashboardBloc(),
        ),
        BlocProvider(
          create: (context) => LoginFormBloc(),
        ),
        BlocProvider(
          create: (context) => RegisFormBloc(),
        ),
        BlocProvider(
          create: (context) => VerificationFormBloc(),
        ),
        BlocProvider(
          create: (context) => ForgotPasswordFormBloc(),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(),
        ),
        BlocProvider(
          create: (context) => LanguageBloc(),
        ),
        BlocProvider(
          create: (context) => NotificationBloc(),
        ),
        BlocProvider(
          create: (_) => di.locator<TrainCreateBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TrainUpdateBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TrainRemoveBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLogIn = false;
  User? user;
  bool _isFirst = true;

  @override
  void initState() {
    Future.microtask(() {
      context.read<ThemeManagerBloc>().add(const LoadTheme());
    });
    isLogin();
    super.initState();
  }

  void isLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLogIn = prefs.getBool('isLogIn') ?? false;
      if (_isLogIn == true) {
        user = FirebaseAuth.instance.currentUser!;
      }
      print(_isLogIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeManagerBloc, ThemeManagerState>(
      builder: (context, theme) {
        return BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, localization) {
            return MaterialApp(
              title: "Batur-App",
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: (theme.isDark == ThemeModeEnum.lightTheme)
                  ? ThemeMode.light
                  : (theme.isDark == ThemeModeEnum.darkTheme)
                      ? ThemeMode.dark
                      : ThemeMode.system,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('id', ''),
                Locale('en', ''),
              ],
              home: (_isFirst)
                  ? const OnBoardingScreen()
                  : (_isLogIn)
                      ? DashboardScreen()
                      : const DashboardScreen(),
              locale: (localization.language == LanguageEnum.england)
                  ? const Locale('en')
                  : const Locale('id'),
            );
          },
        );
      },
    );
  }
}
