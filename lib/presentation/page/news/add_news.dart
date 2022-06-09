import 'dart:io';
import 'package:capstone_design/data/service/img_service.dart';
import 'package:capstone_design/presentation/page/news/news.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

File? image;
String? imageName, judul, konten, urlName;

class AddNews extends StatefulWidget {
  AddNews({Key? key}) : super(key: key);

  @override
  State<AddNews> createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNews> {
  final DateTime _dateTime = DateTime.now();
  // ImgService imgService = ImgService();

  @override
  void initState() {
    setState(() {});
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

  void addNews(BuildContext context) {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child(imageName! + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(image!);
    User user = FirebaseAuth.instance.currentUser!;
    FirebaseFirestore.instance.runTransaction((transaction) async {
      CollectionReference reference =
          FirebaseFirestore.instance.collection("News");
      uploadTask.then((res) async {
        urlName = await res.ref.getDownloadURL();
        if (judul != null && konten != null) {
          await reference.add({
            "username": user.email,
            "date": _dateTime.toString(),
            "coverUrl": urlName,
            "title": judul,
            "content": konten,
          });
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return News();
          }));
          image = null;
          imageName = null;
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add News"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("News API"),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    judul = value;
                  });
                },
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Masukkan judul',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    konten = value;
                  });
                },
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Masukkan Isi konten',
                ),
              ),
            ),
            (image == null) ? Text("Tidak ada gambar") : Image.file(image!),
            Hero(
              tag: "change",
              child: ElevatedButton(
                onPressed: () {
                  (image == null) ? pickImg() : addNews(context);
                  setState(() {});
                },
                child: Text((image == null) ? "Insert Image" : "Submit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
