import 'dart:io';
import 'package:latlong2/latlong.dart';
import 'package:capstone_design/presentation/page/dashboard.dart';
import 'package:capstone_design/presentation/page/login.dart';
import 'package:capstone_design/presentation/page/news/news.dart';
import 'package:capstone_design/presentation/page/profile/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class Resource {
//   final Status status;
//   Resource({required this.status});
// }

// enum Status { success, error, cancelled }

class ApiService {
  final FirebaseAuth firebaseauth = FirebaseAuth.instance;
  final GoogleSignIn googlesignin = GoogleSignIn();

  Future<void> signInbyGoogle(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogIn', true);
    final GoogleSignInAccount? googleUser = await googlesignin.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential authResult =
        await firebaseauth.signInWithCredential(credential);
    final User user = authResult.user!;
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);

    final User currentUser = firebaseauth.currentUser!;
    assert(user.uid == currentUser.uid);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return Dashboard(
        user: user,
      );
    }));
  }

  Future<void> signInWithFacebook(BuildContext context) async {
    final LoginResult result = await FacebookAuth.instance.login();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogIn', true);
    final AuthCredential facebookCredential =
        FacebookAuthProvider.credential(result.accessToken!.token);
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(facebookCredential);
    final User user = userCredential.user!;
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return Dashboard(
        user: user,
      );
    }));
  }

  Future<void> loginWithEmail(
      BuildContext context, String email, String pass) async {
    UserCredential user =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: pass,
    );
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return Dashboard(user: user.user!);
      },
    ));
  }

  Future<void> signInWithEmail(
      BuildContext context, String email, String pass) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: pass,
    );
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return Login();
      },
    ));
  }

  Future sendNews(
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
          return News();
        }));
      });
    });
  }

  Future editNews(
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
            return News();
          }));
        });
      } else {
        reference.doc(index.id).update({
          "coverUrl": urlNameNow,
          "title": judulNow,
          "content": kontenNow,
        });
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return News();
        }));
      }
    });
  }

  Future<void> deleteNews(DocumentReference index, String coverUrl) async {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(index);
      FirebaseStorage.instance.refFromURL(coverUrl).delete();
      transaction.delete(snapshot.reference);
    });
  }

  Future<void> sendProfile(BuildContext context, String username,
      String fullname, String imageName, email, File image, User user) async {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      CollectionReference reference =
          FirebaseFirestore.instance.collection("Profile");
      Reference ref = FirebaseStorage.instance
          .ref()
          .child(imageName + DateTime.now().toString());
      UploadTask uploadTask = ref.putFile(image);
      uploadTask.then((res) async {
        String urlName = await res.ref.getDownloadURL();
        await reference.add({
          "email": email,
          "username": username,
          "fullname": fullname,
          "imgUrl": urlName,
          "status": "User",
        });
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return Dashboard(
            user: user,
          );
        }));
      });
    });
  }

  Future<void> editProfile(
      BuildContext context,
      String usernameNow,
      String fullnameNow,
      String? imageName,
      String urlNameNow,
      File? image,
      DocumentReference index) async {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      CollectionReference reference =
          FirebaseFirestore.instance.collection("Profile");
      UploadTask? uploadTask;
      if (image != null) {
        Reference ref = FirebaseStorage.instance
            .ref()
            .child(imageName! + DateTime.now().toString());
        uploadTask = ref.putFile(image);
        uploadTask.then((res) async {
          FirebaseStorage.instance.refFromURL(urlNameNow).delete();
          urlNameNow = await res.ref.getDownloadURL();
          await reference.doc(index.id).update({
            "username": usernameNow,
            "fullname": fullnameNow,
            "imgUrl": urlNameNow,
          });
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return Profile();
          }));
        });
      } else {
        uploadTask = null;
        await reference.doc(index.id).update({
          "username": usernameNow,
          "fullname": fullnameNow,
          "imgUrl": urlNameNow,
        });
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return Profile();
        }));
      }
    });
  }

  Future<void> sendUmkm(BuildContext context, String imageName, name, type,
      File image, Position currentLocation) async {
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
          "name": name,
          "email": user.email,
          "latitude": currentLocation.latitude,
          "longitude": currentLocation.longitude,
          "coverUrl": urlName,
          "type": type,
          "verivication": false,
        });
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return Dashboard(user: user);
        }));
      });
    });
  }

  Future<void> editUmkm(
      BuildContext context,
      File? image,
      String coverUrlNow,
      imageName,
      nameNow,
      typeNow,
      LatLng center,
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
            "latitude": center.latitude,
            "longitude": center.longitude,
            "coverUrl": coverUrlNow,
            "type": typeNow,
          });
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return Dashboard(user: user);
          }));
        });
      } else {
        await reference.doc(index.id).update({
          "name": nameNow,
          "latitude": center.latitude,
          "longitude": center.longitude,
          "coverUrl": coverUrlNow,
          "type": typeNow,
        });
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return Dashboard(user: user);
        }));
      }
    });
  }
}
