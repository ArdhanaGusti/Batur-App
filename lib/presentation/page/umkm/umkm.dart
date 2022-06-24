import 'package:cached_network_image/cached_network_image.dart';
import 'package:capstone_design/data/service/api_service.dart';
import 'package:capstone_design/presentation/bloc/umkm/umkm_event.dart';
import 'package:capstone_design/presentation/bloc/umkm/umkm_remove_bloc.dart';
import 'package:capstone_design/presentation/bloc/umkm/umkm_state.dart';
import 'package:capstone_design/presentation/page/umkm/edit_umkm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UMKM extends StatelessWidget {
  const UMKM({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("UMKM").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Buat UMKM"),
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
                    CachedNetworkImage(
                      imageUrl: '${data[index]['coverUrl']}',
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    // Image.network("${data[index]['coverUrl']}"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return EditUmkm(
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
                        BlocConsumer<UmkmRemoveBloc, UmkmState>(
                            listener: (context, state) async {
                          if (state is UmkmLoading) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: CircularProgressIndicator(),
                            ));
                          } else if (state is UmkmRemoved) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(state.result),
                            ));
                          } else if (state is UmkmError) {
                            await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text(state.message),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Kembali"),
                                      )
                                    ],
                                  );
                                });
                          }
                        }, builder: (context, state) {
                          return ElevatedButton(
                              onPressed: () {
                                context.read<UmkmRemoveBloc>().add(OnRemoveUmkm(
                                    data[index]['coverUrl'],
                                    data[index].reference));
                              },
                              child: Text("Delete UMKM"));
                        })
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
