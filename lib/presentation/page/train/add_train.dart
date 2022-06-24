import 'package:capstone_design/data/service/api_service.dart';
import 'package:capstone_design/presentation/bloc/train/train_create_bloc.dart';
import 'package:capstone_design/presentation/bloc/train/train_event.dart';
import 'package:capstone_design/presentation/bloc/train/train_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTrain extends StatefulWidget {
  const AddTrain({Key? key}) : super(key: key);

  @override
  State<AddTrain> createState() => _AddTrainState();
}

class _AddTrainState extends State<AddTrain> {
  List<String> train = ["Ka1", "Ka2", "Ka3", "Ka4", "Ka5"];
  List<String> stations = ["Padalarang", "Lembang", "Karawang"];
  String trainName = "Ka1";
  String station = "Padalarang";
  DateTime time = DateTime.now();
  String date = "";

  Future pickDateAndTime() async {
    DateTime? dataDate = await showDatePicker(
        context: context,
        initialDate: time,
        firstDate: DateTime(2022),
        lastDate: DateTime(2040));
    if (dataDate == null) {
      return;
    }
    TimeOfDay? dataTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: time.hour, minute: time.minute));
    if (dataTime == null) {
      return;
    }
    setState(() {
      time = DateTime(
        dataDate.year,
        dataDate.month,
        dataDate.day,
        dataTime.hour,
        dataTime.minute,
      );
      date =
          "${time.day}.${time.month}.${time.year}  ${time.hour}:${time.minute}";
    });
  }

  @override
  void initState() {
    setState(() {
      date =
          "${time.day}.${time.month}.${time.year}.${time.hour}.${time.minute}";
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Train"),
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
                    value: trainName,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    onChanged: (String? newValue) {
                      setState(() {
                        trainName = newValue!;
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
                    value: station,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    onChanged: (String? newValue) {
                      setState(() {
                        station = newValue!;
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
                        pickDateAndTime();
                      },
                      child: Text(date)),
                ],
              ),
            ),
            BlocConsumer<TrainCreateBloc, TrainState>(
                listener: (context, state) async {
              if (state is TrainLoading) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: CircularProgressIndicator(),
                ));
              } else if (state is TrainCreated) {
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
                    if (trainName != null && station != null) {
                      context.read<TrainCreateBloc>().add(
                          OnCreateTrain(context, trainName, station, time));
                      // ApiService().sendTrain(context, trainName, station, s!);
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
