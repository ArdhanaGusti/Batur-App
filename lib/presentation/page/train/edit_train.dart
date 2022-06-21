import 'package:capstone_design/data/service/api_service.dart';
import 'package:capstone_design/presentation/bloc/train/train_event.dart';
import 'package:capstone_design/presentation/bloc/train/train_state.dart';
import 'package:capstone_design/presentation/bloc/train/train_update_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditTrain extends StatefulWidget {
  final String trainName, station;
  final DateTime time;
  final DocumentReference index;
  const EditTrain(
      {Key? key,
      required this.trainName,
      required this.station,
      required this.time,
      required this.index})
      : super(key: key);

  @override
  State<EditTrain> createState() => _EditTrainState();
}

class _EditTrainState extends State<EditTrain> {
  List<String> train = ["Ka1", "Ka2", "Ka3", "Ka4", "Ka5"];
  List<String> stations = ["Padalarang", "Lembang", "Karawang"];
  String? trainNameNow, stationNow;
  DateTime? timeNow;
  String date = "";

  @override
  void initState() {
    trainNameNow = widget.trainName;
    stationNow = widget.station;
    timeNow = widget.time;
    setState(() {
      date = "${timeNow!.day}.${timeNow!.month}.${timeNow!.year}";
    });
    super.initState();
  }

  Future _selectDueDate(BuildContext context) async {
    final picked = await showDatePicker(
        context: context,
        initialDate: timeNow!,
        firstDate: DateTime(2022),
        lastDate: DateTime(2040));

    if (picked != null) {
      setState(() {
        timeNow = picked;
        date = "${picked.day}.${picked.month}.${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Train"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Train API"),
            Padding(
              padding: EdgeInsets.all(10),
              child: InputDecorator(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Nama Kereta"),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: trainNameNow,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    onChanged: (String? newValue) {
                      setState(() {
                        trainNameNow = newValue!;
                      });
                    },
                    items: train.map<DropdownMenuItem<String>>((String e) {
                      return DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: InputDecorator(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Nama Stasiun"),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: stationNow,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    onChanged: (String? newValue) {
                      setState(() {
                        stationNow = newValue!;
                      });
                    },
                    items: stations.map<DropdownMenuItem<String>>((String e) {
                      return DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.calendar_month),
                  GestureDetector(
                      onTap: () {
                        _selectDueDate(context);
                      },
                      child: Text(date)),
                ],
              ),
            ),
            BlocConsumer<TrainUpdateBloc, TrainState>(
                listener: (context, state) async {
              if (state is TrainLoading) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: CircularProgressIndicator(),
                ));
              } else if (state is TrainUpdated) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.result),
                ));
              } else if (state is TrainError) {
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
              return Hero(
                tag: "change",
                child: ElevatedButton(
                  onPressed: () async {
                    if (trainNameNow != null && stationNow != null) {
                      context.read<TrainUpdateBloc>().add(OnUpdateTrain(
                            context,
                            trainNameNow!,
                            stationNow!,
                            timeNow!,
                            widget.index,
                          ));
                    } else {
                      AlertDialog alert = AlertDialog(
                        title: Text("Silahkan lengkapi data"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Ok"))
                        ],
                      );
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    }
                  },
                  child: Text("Submit"),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
