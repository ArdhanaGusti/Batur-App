import 'package:capstone_design/data/service/api_service.dart';
import 'package:capstone_design/presentation/page/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_login/twitter_login.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class Resource {
  final Status status;
  Resource({required this.status});
}

enum Status { Success, Error, Cancelled }

class _LoginState extends State<Login> {
  String? email, pass;
  ApiService apiservice = ApiService();

  Future<Resource?> signInWithTwitter() async {
    final twitterLogin = TwitterLogin(
      apiKey: "",
      apiSecretKey: "",
      redirectURI: "Batur-app://",
    );
    final authResult = await twitterLogin.login();

    switch (authResult.status) {
      case TwitterLoginStatus.loggedIn:
        final AuthCredential twitterAuthCredential =
            TwitterAuthProvider.credential(
                accessToken: authResult.authToken!,
                secret: authResult.authTokenSecret!);

        final userCredential = await FirebaseAuth.instance
            .signInWithCredential(twitterAuthCredential);
        print(userCredential.additionalUserInfo);
        return Resource(status: Status.Success);
      case TwitterLoginStatus.cancelledByUser:
        return Resource(status: Status.Success);
      case TwitterLoginStatus.error:
        return Resource(status: Status.Error);
      default:
        return null;
    }
  }

  Future signInWithEmail() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: "Name"),
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(hintText: "Pass"),
              onChanged: (value) {
                setState(() {
                  pass = value;
                });
              },
            ),
            ElevatedButton(
                onPressed: () async {
                  if (email != null && pass != null) {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email!,
                      password: pass!,
                    );
                  } else {
                    AlertDialog alert = AlertDialog(
                      title: Text("Silahkan lengkapi data"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Ok"))
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  }
                },
                child: const Text("Submit")),
            ElevatedButton(
              onPressed: () {
                apiservice.signInbyGoogle(context);
              },
              child: const Text("Google"),
            ),
            ElevatedButton(
              onPressed: () {
                apiservice.signInWithFacebook(context);
              },
              child: const Text("Facebook"),
            ),
            ElevatedButton(
              onPressed: () {
                signInWithTwitter();
              },
              child: const Text("Twitter"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return Register();
                  },
                ));
              },
              child: const Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
