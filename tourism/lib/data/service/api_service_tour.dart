import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ApiServiceTour {
  final FirebaseAuth firebaseauth = FirebaseAuth.instance;

  Future<void> addFavorite(
      double rating, String address, String tour, String urlName) async {
    User user = FirebaseAuth.instance.currentUser!;
    FirebaseFirestore.instance.runTransaction((transaction) async {
      CollectionReference reference =
          FirebaseFirestore.instance.collection("FavoriteTour");
      await reference.add({
        "email": user.email,
        "urlName": urlName,
        "tour": tour,
        "rating": rating,
        "address": address,
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
