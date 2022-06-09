import 'package:capstone_design/presentation/page/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? email, pass;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
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
              ElevatedButton(
                  onPressed: () async {
                    if (email != null && pass != null) {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: email!,
                        password: pass!,
                      );
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return Login();
                        },
                      ));
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
                  child: Text("Submit")),
            ],
          ),
        ));
  }
}
