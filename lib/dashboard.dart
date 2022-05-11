import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Dashboard extends StatelessWidget {
  final User user;
  final GoogleSignIn googlesignin;
  const Dashboard({Key? key, required this.user, required this.googlesignin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        animationCurve: Curves.bounceOut,
        height: 60.0,
        items: const <Widget>[
          Icon(Icons.add, size: 30),
          Icon(Icons.list, size: 30),
          Icon(Icons.compare_arrows, size: 30),
        ],
      ),
      body: Container(
        color: Colors.green,
        child: const Center(
          child: Text("Halaman 1"),
        ),
      ),
    );
  }
}
