import 'dart:io';
import 'package:core/core.dart';
// import 'package:latlong2/latlong.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiServiceUMKM {
  Future<void> deleteUmkm(DocumentReference index, String coverUrl) async {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(index);
      FirebaseStorage.instance.refFromURL(coverUrl).delete();
      transaction.delete(snapshot.reference);
    });
  }

  Future<void> sendUmkm(
      BuildContext context,
      String imageName,
      String name,
      String type,
      String desc,
      String address,
      String phone,
      String? shopee,
      String? tokped,
      String? website,
      File image,
      double latitude,
      double longitude) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child(imageName + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(image);
    User user = FirebaseAuth.instance.currentUser!;
    FirebaseFirestore.instance.runTransaction((transaction) async {
      CollectionReference reference =
          FirebaseFirestore.instance.collection("UMKM");
      uploadTask.then((res) async {
        String urlName = await res.ref.getDownloadURL();
        await reference.add({
          "address": address,
          "phone": phone,
          "shopee": shopee,
          "tokped": tokped,
          "website": website,
          "name": name,
          "email": user.email,
          "latitude": latitude,
          "longitude": longitude,
          "coverUrl": urlName,
          "type": type,
          "desc": desc,
          "verification": false,
        });
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        //   return Dashboard(user: user);
        // }));
      });
    });
  }

  Future<void> editUmkm(
      BuildContext context,
      File? image,
      String coverUrlNow,
      String? imageName,
      String nameNow,
      String typeNow,
      String descNow,
      double latitude,
      double longitude,
      DocumentReference index) async {
    UploadTask? uploadTask;
    if (image != null) {
      FirebaseStorage.instance.refFromURL(coverUrlNow).delete();
      Reference ref = FirebaseStorage.instance
          .ref()
          .child(imageName! + DateTime.now().toString());
      uploadTask = ref.putFile(image);
    } else {
      uploadTask = null;
    }
    User user = FirebaseAuth.instance.currentUser!;
    FirebaseFirestore.instance.runTransaction((transaction) async {
      CollectionReference reference =
          FirebaseFirestore.instance.collection("UMKM");
      if (image != null) {
        uploadTask!.then((res) async {
          FirebaseStorage.instance.refFromURL(coverUrlNow).delete();
          coverUrlNow = await res.ref.getDownloadURL();
          await reference.doc(index.id).update({
            "name": nameNow,
            "latitude": latitude,
            "longitude": longitude,
            "coverUrl": coverUrlNow,
            "type": typeNow,
            "desc": descNow
          });
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          //   return Dashboard(user: user);
          // }));
        });
      } else {
        await reference.doc(index.id).update({
          "name": nameNow,
          "latitude": latitude,
          "longitude": longitude,
          "coverUrl": coverUrlNow,
          "type": typeNow,
          "desc": descNow
        });
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        //   return Dashboard(user: user);
        // }));
      }
    });
  }

  Future<void> addFavorite(String urlName, String address, String seller,
      String email, String umkm) async {
    User user = FirebaseAuth.instance.currentUser!;
    FirebaseFirestore.instance.runTransaction((transaction) async {
      CollectionReference reference =
          FirebaseFirestore.instance.collection("Favorite");
      await reference.add({
        "email": user.email,
        "umkm": umkm,
        "coverUrl": urlName,
        "address": address,
        "seller": seller,
      });
    });
  }

  Future<void> removeFavorite(DocumentReference index) async {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(index);
      transaction.delete(snapshot.reference);
    });
  }
}
