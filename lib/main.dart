import 'dart:async';

import 'package:capstone_design/dashboard.dart';
import 'package:capstone_design/domain/usecase/get_first_open.dart';
import 'package:capstone_design/login.dart';
import 'package:capstone_design/presentation/bloc/login_form_bloc.dart';
import 'package:capstone_design/presentation/screens/dashboard_screen.dart';
import 'package:capstone_design/presentation/screens/on_boarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme/presentation/injection/theme_injection.dart' as ti;
import 'package:capstone_design/presentation/injection/injection.dart' as di;
import 'package:theme/theme.dart';

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
          create: (context) => LoginFormBloc(),
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
  bool _isFirst = true;
  User? user;
  final GetIsFirstOpen getIsFirstOpen = di.locator<GetIsFirstOpen>();

  @override
  void initState() {
    Future.microtask(() {
      context.read<ThemeManagerBloc>().add(const LoadTheme());
    });
    isLogin();
    isFirstTime();
    super.initState();
  }

  void isFirstTime() async {
    final result = await getIsFirstOpen.execute();
    setState(() {
      _isFirst = result;
    });
  }

  void isLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLogIn = prefs.getBool('isLogIn') ?? false;
      if (_isLogIn == true) {
        user = FirebaseAuth.instance.currentUser!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeManagerBloc, ThemeManagerState>(
      builder: (context, state) {
        return MaterialApp(
          title: "Batur-App",
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: (state.isDark == ThemeModeEnum.lightTheme)
              ? ThemeMode.light
              : (state.isDark == ThemeModeEnum.darkTheme)
                  ? ThemeMode.dark
                  : ThemeMode.system,
          home: (_isFirst)
              ? const OnBoardingScreen()
              : _isLogIn == true
                  ? Dashboard(user: user!)
                  : const DashboardScreen(),
        );
      },
    );
  }
}
