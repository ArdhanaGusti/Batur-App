import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/presentation/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

class ApiServiceTrans {
  Future<void> sendTrain(BuildContext context, String trainName, String station,
      DateTime time) async {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      CollectionReference reference =
          FirebaseFirestore.instance.collection("Train");
      await reference.add({
        "trainName": trainName,
        "date": time,
        "station": station,
      });
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return DashboardScreen();
      }));
    });
  }

  Future<void> editTrain(BuildContext context, String trainName, String station,
      DateTime time, DocumentReference index) async {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      CollectionReference reference =
          FirebaseFirestore.instance.collection("Train");
      reference.doc(index.id).update({
        "trainName": trainName,
        "date": time,
        "station": station,
      });
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return DashboardScreen();
      }));
    });
  }

  Future<void> deleteTrain(DocumentReference index) async {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(index);
      transaction.delete(snapshot.reference);
    });
  }
}
