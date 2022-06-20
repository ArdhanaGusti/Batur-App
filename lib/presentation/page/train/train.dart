import 'package:capstone_design/data/service/api_service.dart';
import 'package:capstone_design/presentation/bloc/train/train_event.dart';
import 'package:capstone_design/presentation/bloc/train/train_remove_bloc.dart';
import 'package:capstone_design/presentation/bloc/train/train_state.dart';
import 'package:capstone_design/presentation/page/train/edit_train.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Train extends StatefulWidget {
  const Train({Key? key}) : super(key: key);

  @override
  State<Train> createState() => _TrainState();
}

class _TrainState extends State<Train> {
  User? user;

  @override
  void initState() {
    _getUser();
    super.initState();
  }

  void _getUser() async {
    setState(() {
      user = FirebaseAuth.instance.currentUser!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Train List"),
      ),
      body: Column(
        children: [
          Text("Stasiun Padalarang"),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Train")
                .where("station", isEqualTo: "Padalarang")
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return TrainList(
                  document: snapshot.data!.docs,
                );
              }
            },
          ),
          Text("Stasiun Karawang"),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Train")
                .where("station", isEqualTo: "Karawang")
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return TrainList(
                  document: snapshot.data!.docs,
                );
              }
            },
          ),
          Text("Stasiun Lembang"),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Train")
                .where("station", isEqualTo: "Lembang")
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return TrainList(
                  document: snapshot.data!.docs,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class TrainList extends StatelessWidget {
  final List<DocumentSnapshot> document;
  ApiService apiService = ApiService();
  TrainList({Key? key, required this.document}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Nama: " + document[index]['trainName']),
                Text("Berangkat: " +
                    document[index]['date'].toDate().toString()),
                Text("Stasiun: " + document[index]['station']),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return EditTrain(
                              index: document[index].reference,
                              station: document[index]['station'],
                              time: document[index]['date'].toDate(),
                              trainName: document[index]['trainName'],
                            );
                          },
                        ));
                      },
                      child: Text("Edit"),
                      color: Colors.green,
                    ),
                    BlocBuilder<TrainRemoveBloc, TrainState>(
                        builder: (context, state) {
                      return RaisedButton(
                        onPressed: () {
                          context.read<TrainRemoveBloc>().add(OnRemoveTrain(
                                document[index].reference,
                              ));
                        },
                        child: Text("Delete"),
                        color: Colors.red,
                      );
                    }),
                  ],
                )
              ],
            ),
          );
        },
        itemCount: document.length,
        // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //   crossAxisCount: 5,
        //   crossAxisSpacing: 5.0,
        //   mainAxisSpacing: 5.0,
        // ),
      ),
    );
  }
}
