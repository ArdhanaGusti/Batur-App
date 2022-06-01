import 'package:capstone_design/dashboard.dart';
import 'package:capstone_design/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme/presentation/injection/theme_injection.dart' as di;
import 'package:theme/theme.dart';

void main() async {
  di.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    BlocProvider(
      create: (context) => di.locator<ThemeManagerBloc>(),
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
          home: _isLogIn == true ? Dashboard(user: user!) : const Login(),
        );
      },
    );
  }
}
