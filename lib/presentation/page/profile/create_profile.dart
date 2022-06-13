import 'dart:io';
import 'package:capstone_design/data/service/api_service.dart';
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
  ApiService apiService = ApiService();

  void pickImg() async {
    var selectedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      image = File(selectedImage!.path);
      imageName = basename(image!.path);
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
                if (image == null) {
                  pickImg();
                } else {
                  if (username != null && fullname != null) {
                    apiService.sendProfile(
                      context,
                      username!,
                      fullname!,
                      imageName!,
                      widget.user.email,
                      image!,
                      widget.user,
                    );
                    setState(() {
                      image = null;
                      imageName = null;
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
                }
              },
              child: Text((image == null) ? "Pick Image" : "Send Data"),
            ),
          ],
        ),
      ),
    );
  }
}
