import 'package:capstone_design/presentation/bloc/news/news_create_bloc.dart';
import 'package:capstone_design/presentation/page/dashboard.dart';
import 'package:capstone_design/presentation/page/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:capstone_design/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  di.init();
  runApp(MyApp());
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
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<NewsCreateBloc>(),
        ),
      ],
      child: MaterialApp(
        title: "Batur-App",
        debugShowCheckedModeBanner: false,
        home: _isLogIn == true ? Dashboard(user: user!) : const Login(),
      ),
    );
  }
}
