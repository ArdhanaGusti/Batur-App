import 'dart:async';

import 'package:account/account.dart';
import 'package:capstone_design/domain/usecase/get_first_open.dart';
import 'package:capstone_design/presentation/bloc/login/login_email_bloc.dart';
import 'package:capstone_design/presentation/bloc/login/login_facebook_bloc.dart';
import 'package:capstone_design/presentation/bloc/login/login_google_bloc.dart';
import 'package:capstone_design/presentation/bloc/login/sign_in_email_bloc.dart';
import 'package:capstone_design/presentation/bloc/news/news_create_bloc.dart';
import 'package:capstone_design/presentation/bloc/news/news_remove_bloc.dart';
import 'package:capstone_design/presentation/bloc/news/news_update_bloc.dart';
import 'package:capstone_design/presentation/bloc/profile/profile_create_bloc.dart';
import 'package:capstone_design/presentation/bloc/profile/profile_update_bloc.dart';
import 'package:capstone_design/presentation/bloc/tour/tour_create_bloc.dart';
import 'package:capstone_design/presentation/bloc/tour/tour_remove_bloc.dart';
import 'package:capstone_design/presentation/bloc/tour/tour_update_bloc.dart';
import 'package:capstone_design/presentation/bloc/train/train_create_bloc.dart';
import 'package:capstone_design/presentation/bloc/train/train_remove_bloc.dart';
import 'package:capstone_design/presentation/bloc/train/train_update_bloc.dart';
import 'package:capstone_design/presentation/bloc/umkm/umkm_create_bloc.dart';
import 'package:capstone_design/presentation/bloc/umkm/umkm_remove_bloc.dart';
import 'package:capstone_design/presentation/bloc/umkm/umkm_update_bloc.dart';
import 'package:capstone_design/presentation/page/dashboard.dart';

import 'package:core/core.dart';
import 'package:core/presentation/bloc/dashboard_bloc.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme/presentation/injection/theme_injection.dart' as ti;
import 'package:capstone_design/presentation/injection/injection.dart' as di;
import 'package:theme/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  ti.init();
  di.init();
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
          create: (_) => di.locator<NewsCreateBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NewsUpdateBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NewsRemoveBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<ProfileCreateBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<ProfileUpdateBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<UmkmCreateBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<UmkmUpdateBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<UmkmRemoveBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TourUpdateBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TourCreateBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TourRemoveBloc>(),
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
        BlocProvider(
          create: (_) => di.locator<LoginEmailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<LoginGoogleBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<LoginFacebookBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SignInEmailBloc>(),
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
                      ? Dashboard(user: user!)
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
