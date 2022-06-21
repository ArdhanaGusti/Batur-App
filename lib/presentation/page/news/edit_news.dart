import 'dart:io';
import 'package:capstone_design/data/service/api_service.dart';
import 'package:capstone_design/presentation/bloc/news/news_event.dart';
import 'package:capstone_design/presentation/bloc/news/news_state.dart';
import 'package:capstone_design/presentation/bloc/news/news_update_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class EditNews extends StatefulWidget {
  final String judul, konten, urlName;
  final DocumentReference index;
  EditNews({
    Key? key,
    required this.judul,
    required this.konten,
    required this.urlName,
    required this.index,
  }) : super(key: key);

  @override
  State<EditNews> createState() => _EditNewsState();
}

class _EditNewsState extends State<EditNews> {
  ApiService apiService = ApiService();
  File? imageNow;
  String? imageNameNow, judulNow, kontenNow, urlNameNow;
  TextEditingController? titlecontroller;
  TextEditingController? contentcontroller;
  final DateTime _dateTime = DateTime.now();

  @override
  void initState() {
    judulNow = widget.judul;
    kontenNow = widget.konten;
    urlNameNow = widget.urlName;
    titlecontroller = TextEditingController(text: widget.judul);
    contentcontroller = TextEditingController(text: widget.konten);
    super.initState();
  }

  void pickImg() async {
    var selectedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      imageNow = File(selectedImage!.path);
      imageNameNow = basename(imageNow!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit News"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("News API"),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: titlecontroller,
                onChanged: (value) {
                  setState(() {
                    judulNow = value;
                  });
                },
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Masukkan judul',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: contentcontroller,
                onChanged: (value) {
                  setState(() {
                    kontenNow = value;
                  });
                },
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Masukkan Isi konten',
                ),
              ),
            ),
            (imageNow == null)
                ? Image.network(widget.urlName)
                : Image.file(imageNow!),
            ElevatedButton(
                onPressed: () {
                  pickImg();
                },
                child: Text("Pick IMG")),
            BlocConsumer<NewsUpdateBloc, NewsState>(
                listener: (context, state) async {
              if (state is NewsLoading) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: CircularProgressIndicator(),
                ));
              } else if (state is NewsUpdated) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.result),
                ));
              } else if (state is NewsError) {
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
                  onPressed: () {
                    if (judulNow != null && kontenNow != null) {
                      context.read<NewsUpdateBloc>().add(OnUpdateNews(
                          context,
                          imageNow,
                          imageNameNow,
                          judulNow!,
                          kontenNow!,
                          urlNameNow!,
                          widget.index));

                      setState(() {
                        imageNow = null;
                        imageNameNow = null;
                      });
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
            }),
          ],
        ),
      ),
    );
  }
}
