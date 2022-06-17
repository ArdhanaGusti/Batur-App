import 'package:capstone_design/presentation/page/tour/edit_tour.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Tour extends StatelessWidget {
  const Tour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("Tour").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Buat tempat wisata"),
              ),
            ),
          );
        }
        var data = snapshot.data!.docs;
        return Scaffold(
          body: ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                child: Column(
                  children: [
                    Text("Nama umkm: " + data[index]['name']),
                    Text("Nama umkm: " + data[index]['desc']),
                    Text("Jenis: " + data[index]['type']),
                    Image.network("${data[index]['coverUrl']}"),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return EditTour(
                                  coverUrl: data[index]['coverUrl'],
                                  index: data[index].reference,
                                  latitude: data[index]['latitude'],
                                  longitude: data[index]['longitude'],
                                  type: data[index]['type'],
                                  desc: data[index]['desc'],
                                  name: data[index]['name']);
                            },
                          ));
                        },
                        child: Text("Edit"))
                  ],
                ),
              );
            },
            itemCount: snapshot.data!.docs.length,
          ),
        );
      },
    );
  }
}
