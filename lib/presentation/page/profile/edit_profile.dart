import 'dart:io';
import 'package:capstone_design/data/service/api_service.dart';
import 'package:capstone_design/presentation/bloc/profile/profile_event.dart';
import 'package:capstone_design/presentation/bloc/profile/profile_state.dart';
import 'package:capstone_design/presentation/bloc/profile/profile_update_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  final DocumentReference index;
  final String fullname, username, urlName;

  const EditProfile({
    Key? key,
    required this.index,
    required this.urlName,
    required this.username,
    required this.fullname,
  }) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? image;
  String? imageName;
  String? urlNameNow, usernameNow, fullnameNow;
  ApiService apiService = ApiService();
  TextEditingController? usernamecontroller, fullnamecontroller;

  @override
  void initState() {
    usernameNow = widget.username;
    fullnameNow = widget.fullname;
    urlNameNow = widget.urlName;
    usernamecontroller = TextEditingController(text: widget.username);
    fullnamecontroller = TextEditingController(text: widget.fullname);
    super.initState();
  }

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
              controller: usernamecontroller,
              onChanged: (value) {
                setState(() {
                  usernameNow = value;
                });
              },
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), hintText: "Username"),
            ),
            TextField(
              controller: fullnamecontroller,
              onChanged: (value) {
                fullnameNow = value;
              },
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), hintText: "Fullname"),
            ),
            (image == null)
                ? Image.network(widget.urlName)
                : Image.file(image!),
            ElevatedButton(
              onPressed: () {
                pickImg();
              },
              child: Text("Pick Image"),
            ),
            BlocBuilder<ProfileUpdateBloc, ProfileState>(
                builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  if (usernameNow != null && fullnameNow != null) {
                    context.read<ProfileUpdateBloc>().add(OnUpdateProfile(
                        context,
                        usernameNow!,
                        fullnameNow!,
                        imageName,
                        image,
                        urlNameNow!,
                        widget.index));
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
                },
                child: Text("Send Data"),
              );
            }),
          ],
        ),
      ),
    );
  }
}
