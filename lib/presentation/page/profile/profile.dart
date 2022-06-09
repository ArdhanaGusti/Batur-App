import 'package:capstone_design/presentation/page/profile/edit_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("Profile").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              body: Center(
                child: Column(
                  children: [
                    Text("Anda belum mengatur profile"),
                    ElevatedButton(
                        onPressed: () {}, child: Text("Buat profile"))
                  ],
                ),
              ),
            );
          }
          var profile = snapshot.data!.docs;
          return Scaffold(
            body: SafeArea(
              child: Center(
                  child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(profile[0]['imgUrl']),
                  ),
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
                ],
              )),
            ),
          );
        });
  }
}
