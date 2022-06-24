import 'package:capstone_design/presentation/page/profile/create_profile.dart';
import 'package:capstone_design/presentation/page/profile/edit_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Profile")
            .where("email", isEqualTo: FirebaseAuth.instance.currentUser!.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data!.size == 0) {
            return Scaffold(
              body: SafeArea(
                child: Center(
                  child: Column(
                    children: [
                      Text("Anda belum mengatur profile"),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return CreateProfile(
                                    user: FirebaseAuth.instance.currentUser!);
                              },
                            ));
                          },
                          child: Text("Buat profile"))
                    ],
                  ),
                ),
              ),
            );
          } else if (!snapshot.hasData || user == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var profile = snapshot.data!.docs;
            return Scaffold(
              body: SafeArea(
                child: Center(
                    child: Column(
                  children: [
                    (profile[0]['imgUrl'] != null)
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(profile[0]['imgUrl']),
                          )
                        : CircleAvatar(),
                    Text(profile[0]['fullname']),
                    Text(profile[0]['username']),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return EditProfile(
                                  index: profile[0].reference,
                                  urlName: profile[0]['imgUrl'],
                                  username: profile[0]['username'],
                                  fullname: profile[0]['fullname']);
                            },
                          ));
                        },
                        child: Text("Edit Profile")),
                    ElevatedButton(
                        onPressed: () {},
                        child: (profile[0]['status'] == "Admin")
                            ? Text("Adalah admin")
                            : Text("Bukan Admin"))
                  ],
                )),
              ),
            );
          }
        });
  }
}
