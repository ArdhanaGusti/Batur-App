import 'package:capstone_design/presentation/page/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Resource {
  final Status status;
  Resource({required this.status});
}

enum Status { Success, Error, Cancelled }

class ApiService {
  final FirebaseAuth firebaseauth = FirebaseAuth.instance;
  final GoogleSignIn googlesignin = GoogleSignIn();

  Future signInbyGoogle(BuildContext context) async {
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

    final User currentUser = firebaseauth.currentUser!;
    assert(user.uid == currentUser.uid);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return Dashboard(
        user: user,
      );
    }));
  }

  Future signInWithFacebook(BuildContext context) async {
    final LoginResult result = await FacebookAuth.instance.login();
    switch (result.status) {
      case LoginStatus.success:
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLogIn', true);
        final AuthCredential facebookCredential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        final userCredential = await FirebaseAuth.instance
            .signInWithCredential(facebookCredential);
        print(userCredential.additionalUserInfo);
        final User user = userCredential.user!;
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return Dashboard(
            user: user,
          );
        }));
        return Resource(status: Status.Success);
      case LoginStatus.cancelled:
        return Resource(status: Status.Cancelled);
      case LoginStatus.failed:
        return Resource(status: Status.Error);
      default:
        return null;
    }
  }
}
