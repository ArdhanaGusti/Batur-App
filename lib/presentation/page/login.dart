import 'package:capstone_design/data/service/api_service.dart';
import 'package:capstone_design/presentation/bloc/login/login_email_bloc.dart';
import 'package:capstone_design/presentation/bloc/login/login_event.dart';
import 'package:capstone_design/presentation/bloc/login/login_facebook_bloc.dart';
import 'package:capstone_design/presentation/bloc/login/login_google_bloc.dart';
import 'package:capstone_design/presentation/bloc/login/login_state.dart';
import 'package:capstone_design/presentation/page/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

enum Status { success, error, cancelled }

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
        return Resource(status: Status.success);
      case TwitterLoginStatus.cancelledByUser:
        return Resource(status: Status.success);
      case TwitterLoginStatus.error:
        return Resource(status: Status.error);
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(hintText: "Email"),
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
              BlocConsumer<LoginEmailBloc, LoginState>(
                  listener: (context, state) async {
                if (state is LoginLoading) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: CircularProgressIndicator(),
                  ));
                } else if (state is LoginEmailSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.result),
                  ));
                } else if (state is LoginError) {
                  await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text(state.message),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Kembali"),
                            )
                          ],
                        );
                      });
                }
              }, builder: (context, state) {
                return ElevatedButton(
                    onPressed: () {
                      if (email != null && pass != null) {
                        context
                            .read<LoginEmailBloc>()
                            .add(OnLoginEmail(context, email!, pass!));
                        // apiservice.loginWithEmail(context, email!, pass!);
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
                    child: const Text("Submit"));
              }),
              BlocConsumer<LoginGoogleBloc, LoginState>(
                  listener: (context, state) async {
                if (state is LoginLoading) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: CircularProgressIndicator(),
                  ));
                } else if (state is LoginGoogleSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.result),
                  ));
                } else if (state is LoginError) {
                  await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text(state.message),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Kembali"),
                            )
                          ],
                        );
                      });
                }
              }, builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    context.read<LoginGoogleBloc>().add(OnLoginGoogle(context));
                    // apiservice.signInbyGoogle(context);
                  },
                  child: const Text("Google"),
                );
              }),
              BlocConsumer<LoginFacebookBloc, LoginState>(
                  listener: (context, state) async {
                if (state is LoginLoading) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: CircularProgressIndicator(),
                  ));
                } else if (state is LoginFacebookSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.result),
                  ));
                } else if (state is LoginError) {
                  await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text(state.message),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Kembali"),
                            )
                          ],
                        );
                      });
                }
              }, builder: (context, state) {
                return ElevatedButton(
                  onPressed: () {
                    context
                        .read<LoginFacebookBloc>()
                        .add(OnLoginFacebook(context));
                  },
                  child: const Text("Facebook"),
                );
              }),
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
      ),
    );
  }
}
