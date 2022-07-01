import 'dart:async';

import 'package:account/account.dart';

import 'package:core/core.dart';
import 'package:umkm/umkm.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
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
          create: (_) => di.locator<DashboardBloc>(),
        ),
        BlocProvider(
          create: (context) => VerificationFormBloc(),
        ),
        BlocProvider(
          create: (context) => ForgotPasswordFormBloc(),
        ),
        BlocProvider(
          create: (_) => di.locator<ProfileBloc>(),
        ),
        BlocProvider(
          create: (context) => LanguageBloc(),
        ),
        BlocProvider(
          create: (context) => NotificationBloc(),
        ),
        BlocProvider(
          create: (_) => di.locator<LoginFormBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RegisFormBloc>(),
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
          create: (_) => di.locator<UmkmCreateBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<UmkmUpdateBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<UmkmRemoveBloc>(),
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
  bool _isFirst = true;
  final GetIsFirstOpen getIsFirstOpen = di.locator<GetIsFirstOpen>();
  final GetRememberMe getRememberMe = di.locator<GetRememberMe>();

  @override
  void initState() {
    context.read<ThemeManagerBloc>().add(const LoadTheme());
    context.read<DashboardBloc>().add(const IsLogInChange());
    isFirstTime();
    isRememberMe();
    super.initState();
  }

  void isFirstTime() async {
    final result = await getIsFirstOpen.execute();
    setState(() {
      _isFirst = result;
    });
  }

  void isRememberMe() async {
    final result = await getRememberMe.execute();

    if (!result) {
      Future.microtask(() {
        context.read<DashboardBloc>().add(const IsLogInSave(value: false));
        context.read<DashboardBloc>().add(const SingOut());
      });
    }
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
                  : const DashboardScreen(),
              locale: (localization.language == LanguageEnum.inggirs)
                  ? const Locale('en')
                  : const Locale('id'),
            );
          },
        );
      },
    );
  }
}
