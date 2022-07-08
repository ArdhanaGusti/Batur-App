import 'dart:io';
import '../../presentation/screen/news_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import '../../presentation/components/toast/custom_alert_toast.dart';

// class Resource {
//   final Status status;
//   Resource({required this.status});
// }

// enum Status { success, error, cancelled }

class ApiServiceNews {
  final FirebaseAuth firebaseauth = FirebaseAuth.instance;

  Future<void> sendNews(
      BuildContext context, File image, String imageName, judul, konten) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child(imageName + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(image);
    User user = FirebaseAuth.instance.currentUser!;
    FirebaseFirestore.instance.runTransaction((transaction) async {
      CollectionReference reference =
          FirebaseFirestore.instance.collection("News");
      uploadTask.then((res) async {
        String urlName = await res.ref.getDownloadURL();
        await reference.add({
          "username": user.email,
          "date": DateTime.now().toString(),
          "coverUrl": urlName,
          "title": judul,
          "content": konten,
        });
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return DashboardScreen();
        }));
      });
    });
  }

  Future<void> editNews(
      BuildContext context,
      File? imageNow,
      String? imageNameNow,
      String judulNow,
      String kontenNow,
      String urlNameNow,
      DocumentReference index) async {
    UploadTask? uploadTask;
    if (imageNow != null) {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child(imageNameNow! + DateTime.now().toString());
      uploadTask = ref.putFile(imageNow);
    } else {
      uploadTask = null;
    }
    FirebaseFirestore.instance.runTransaction((transaction) async {
      CollectionReference reference =
          FirebaseFirestore.instance.collection("News");
      if (imageNow != null) {
        FirebaseStorage.instance.refFromURL(urlNameNow).delete();
        uploadTask!.then((res) async {
          urlNameNow = await res.ref.getDownloadURL();
          reference.doc(index.id).update({
            "coverUrl": urlNameNow,
            "title": judulNow,
            "content": kontenNow,
          });
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return DashboardScreen();
          }));
        });
      } else {
        reference.doc(index.id).update({
          "coverUrl": urlNameNow,
          "title": judulNow,
          "content": kontenNow,
        });
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return DashboardScreen();
        }));
      }
    });
  }

  Future<void> deleteNews(
      BuildContext context, DocumentReference index, String coverUrl) async {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(index);
      FirebaseStorage.instance.refFromURL(coverUrl).delete();
      transaction.delete(snapshot.reference);
    });
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return DashboardScreen();
    }));
  }
}
