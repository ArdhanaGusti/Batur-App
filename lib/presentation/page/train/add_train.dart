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

  Future _selectDueDate(BuildContext context) async {
    final picked = await showDatePicker(
        context: context,
        initialDate: time,
        firstDate: DateTime(2022),
        lastDate: DateTime(2040));

    if (picked != null) {
      setState(() {
        time = picked;
        date = "${picked.day}.${picked.month}.${picked.year}";
      });
    }
  }

  @override
  void initState() {
    setState(() {
      date = "${time.day}.${time.month}.${time.year}";
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
                        _selectDueDate(context);
                      },
                      child: Text(date)),
                ],
              ),
            ),
            BlocBuilder<TrainCreateBloc, TrainState>(builder: (context, state) {
              return Hero(
                tag: "change",
                child: ElevatedButton(
                  onPressed: () async {
                    if (trainName != null && station != null) {
                      // ApiService().sendTrain(context, trainName, station, time);
                      context.read<TrainCreateBloc>().add(
                          OnCreateTrain(context, trainName, station, time));
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
