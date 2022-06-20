import 'package:capstone_design/data/service/api_service.dart';
import 'package:capstone_design/presentation/bloc/tour/tour_event.dart';
import 'package:capstone_design/presentation/bloc/tour/tour_remove_bloc.dart';
import 'package:capstone_design/presentation/bloc/tour/tour_state.dart';
import 'package:capstone_design/presentation/page/tour/edit_tour.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Tour extends StatelessWidget {
  const Tour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Tour")
          .where("email", isEqualTo: FirebaseAuth.instance.currentUser!.email)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data!.size == 0) {
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
                    Row(
                      children: [
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
                            child: Text("Edit")),
                        BlocBuilder<TourRemoveBloc, TourState>(
                            builder: (context, state) {
                          return ElevatedButton(
                              onPressed: () {
                                context.read<TourRemoveBloc>().add(OnRemoveTour(
                                    data[index]['coverUrl'],
                                    data[index].reference));
                              },
                              child: Text("Hapus Wisata"));
                        }),
                      ],
                    )
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
