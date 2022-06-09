import 'dart:io';
import 'package:capstone_design/presentation/page/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateProfile extends StatefulWidget {
  final User user;
  const CreateProfile({Key? key, required this.user}) : super(key: key);

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  File? image;
  String? imageName;
  String? urlName, username, fullname;
  void pickImg() async {
    var selectedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      image = File(selectedImage!.path);
      imageName = basename(image!.path);
    });
  }

  void sendData(BuildContext context) async {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      CollectionReference reference =
          FirebaseFirestore.instance.collection("Profile");
      if (username != null && fullname != null) {
        Reference ref = FirebaseStorage.instance
            .ref()
            .child(imageName! + DateTime.now().toString());
        UploadTask uploadTask = ref.putFile(image!);
        uploadTask.then((res) async {
          urlName = await res.ref.getDownloadURL();
          await reference.add({
            "email": widget.user.email,
            "username": username,
            "fullname": fullname,
            "imgUrl": urlName,
            "status": "User",
          });
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return Dashboard(
              user: widget.user,
            );
          }));
        });
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  username = value;
                });
              },
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), hintText: "Username"),
            ),
            TextField(
              onChanged: (value) {
                fullname = value;
              },
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), hintText: "Fullname"),
            ),
            (image == null) ? Text("No image yet") : Image.file(image!),
            ElevatedButton(
              onPressed: () {
                (image == null) ? pickImg() : sendData(context);
              },
              child: Text((image == null) ? "Pick Image" : "Send Data"),
            ),
          ],
        ),
      ),
    );
  }
}
