import 'dart:io';
import 'package:capstone_design/data/service/api_service.dart';
import 'package:capstone_design/presentation/bloc/news/news_create_bloc.dart';
import 'package:capstone_design/presentation/bloc/news/news_event.dart';
import 'package:capstone_design/presentation/bloc/news/news_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class AddNews extends StatefulWidget {
  const AddNews({Key? key}) : super(key: key);

  @override
  State<AddNews> createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNews> {
  File? image;
  String? imageName, judul, konten, urlName;

  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  void pickImg() async {
    var selectedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(selectedImage!.path);
      imageName = basename(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add News"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("News API"),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    judul = value;
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
                onChanged: (value) {
                  setState(() {
                    konten = value;
                  });
                },
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Masukkan Isi konten',
                ),
              ),
            ),
            (image == null) ? Text("Tidak ada gambar") : Image.file(image!),
            BlocBuilder<NewsCreateBloc, NewsState>(builder: (context, state) {
              return Hero(
                tag: "change",
                child: ElevatedButton(
                  onPressed: () async {
                    if (image == null) {
                      pickImg();
                    } else {
                      if (judul != null && konten != null) {
                        context.read<NewsCreateBloc>().add(OnCreateNews(
                            context, image!, imageName!, judul!, konten!));
                        setState(() {
                          image = null;
                          imageName = null;
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
                    }
                  },
                  child: Text((image == null) ? "Insert Image" : "Submit"),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
