import 'package:capstone_design/presentation/page/dua.dart';
import 'package:capstone_design/presentation/page/login.dart';
import 'package:capstone_design/presentation/page/satu.dart';
import 'package:capstone_design/presentation/page/tiga.dart';
import 'dart:async';
import 'package:capstone_design/login.dart';
import 'package:capstone_design/main.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  final User user;
  const Dashboard({Key? key, required this.user}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GoogleSignIn googlesignin = GoogleSignIn();
  int index = 0;
  List pages = [
    // Satu(),
    Dua(),
    Tiga(),
  ];

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text("Batur App"),
        actions: [
          IconButton(
            onPressed: () async {
              googlesignin.signOut();
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              prefs.setBool('isLogIn', false);
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return MyApp();
              }));
            },
            icon: const Icon(Icons.output_sharp),
          )
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: index,
        onTap: (page) {
          setState(() {
            index = page;
          });
        },
        backgroundColor: Colors.transparent,
        color: Colors.blueAccent,
        animationCurve: Curves.bounceOut,
        height: 60.0,
        items: const <Widget>[
          Icon(Icons.add, size: 30),
          Icon(Icons.list, size: 30),
          Icon(Icons.person, size: 30),
        ],
      ),
      body: pages[index],
    );
  }
}
