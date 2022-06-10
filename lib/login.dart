import 'dart:async';

import 'package:capstone_design/dashboard.dart';
import 'package:capstone_design/presentation/components/custom_app_bar.dart';
import 'package:capstone_design/presentation/screens/UMKM/status_register_umkm_screen.dart';
import 'package:capstone_design/presentation/screens/UMKM/umkm_detail_acc_screen.dart';
import 'package:capstone_design/presentation/screens/card_screen.dart';
import 'package:capstone_design/presentation/screens/favorite/favorite_screen.dart';
import 'package:capstone_design/presentation/screens/favorite/favorite_screen.dart';
import 'package:capstone_design/presentation/screens/home_screen.dart';
import 'package:capstone_design/presentation/screens/icon_button_screen.dart';
import 'package:capstone_design/presentation/screens/news/news_screen.dart';
import 'package:capstone_design/presentation/screens/notifikasi/notifikasi_screen.dart';
import 'package:capstone_design/presentation/screens/text_button_screen.dart';
import 'package:capstone_design/presentation/screens/text_icon_button_screen.dart';
import 'package:capstone_design/presentation/screens/theme_setting_screen.dart';
import 'package:capstone_design/presentation/screens/toast_screen.dart';
import 'package:capstone_design/presentation/screens/transportasi/transportasi_screen.dart';
import 'package:capstone_design/presentation/screens/validation_button_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth firebaseauth = FirebaseAuth.instance;
  final GoogleSignIn googlesignin = GoogleSignIn();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      FlutterNativeSplash.remove();
    });
  }

  Future _signInbyGoogle() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogIn', true);
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
    // assert(await user.getIdToken() != null);

    final User currentUser = firebaseauth.currentUser!;
    assert(user.uid == currentUser.uid);

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return Dashboard(
        user: user,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Center(
              child: Column(
                children: [
                  const CustomAppBar(
                    title: "Batur App",
                    hamburgerMenu: true,
                  ),
                  const TextField(),
                  const TextField(),
                  ElevatedButton(onPressed: () {}, child: const Text("Submit")),
                  ElevatedButton(
                    onPressed: _signInbyGoogle,
                    child: const Text("Google"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ThemeSettingScreen(),
                        ),
                      );
                    },
                    child: const Text("Theme"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TextButtonScreen(),
                        ),
                      );
                    },
                    child: const Text("Text Button"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TextIconButtonScreen(),
                        ),
                      );
                    },
                    child: const Text("Text Icon Button"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const IconButtonScreen(),
                        ),
                      );
                    },
                    child: const Text("Icon Button"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ValidationButtonScreen(),
                        ),
                      );
                    },
                    child: const Text("Validation Button"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CardScreen(),
                        ),
                      );
                    },
                    child: const Text("Card Screen"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ToastScreen(),
                        ),
                      );
                    },
                    child: const Text("Toast Screen"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const StatusRegisterUmkmScreen(),
                        ),
                      );
                    },
                    child: const Text("Status Register UMKM Screen"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UmkmDetailAccScreen(),
                        ),
                      );
                    },
                    child: const Text("UMKM detail acc"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                    child: const Text("Home Screen"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NewsScreen(),
                        ),
                      );
                    },
                    child: const Text("News Screen"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FavoriteScreen(),
                        ),
                      );
                    },
                    child: const Text("Favorite Screen"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotifikasiScreen(),
                        ),
                      );
                    },
                    child: const Text("Notifikasi Screen"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TransportasiScreen(),
                        ),
                      );
                    },
                    child: const Text("Transportasi Screen"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
