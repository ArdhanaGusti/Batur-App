import 'package:cloud_firestore/cloud_firestore.dart';

class ApiServiceUmkm {
  Future<void> addFavorite(String username, String email, String umkm) async {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      CollectionReference reference =
          FirebaseFirestore.instance.collection("Favorite");
      await reference.add({
        "username": username,
        "email": email,
        "umkm": umkm,
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
