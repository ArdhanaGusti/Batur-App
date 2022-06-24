import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Dua extends StatefulWidget {
  const Dua({Key? key}) : super(key: key);

  @override
  State<Dua> createState() => _DuaState();
}

class _DuaState extends State<Dua> {
  User? user;

  @override
  void initState() {
    _getUser();
    super.initState();
  }

  void _getUser() async {
    setState(() {
      user = FirebaseAuth.instance.currentUser!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("${user!.displayName}"),
      ),
    );
  }
}
