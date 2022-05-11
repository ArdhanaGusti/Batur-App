import 'package:capstone_design/dashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth firebaseauth = FirebaseAuth.instance;
  final GoogleSignIn googlesignin = GoogleSignIn();

  void _signIn() async {
    final GoogleSignInAccount? googleUser = await googlesignin.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential authResult =
        await firebaseauth.signInWithCredential(credential);
    final User user = authResult.user!;
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = firebaseauth.currentUser!;
    assert(user.uid == currentUser.uid);

    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Dashboard(
        user: user,
        googlesignin: googlesignin,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const TextField(),
            const TextField(),
            ElevatedButton(onPressed: () {}, child: const Text("Submit")),
            ElevatedButton(
              onPressed: _signIn,
              child: const Text("Google"),
            )
          ],
        ),
      ),
    );
  }
}
