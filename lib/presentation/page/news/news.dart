import 'package:capstone_design/data/service/api_service.dart';
import 'package:capstone_design/presentation/page/news/edit_news.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
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
        title: Text("News List"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("News").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return NewsList(
              document: snapshot.data!.docs,
            );
          }
        },
      ),
    );
  }
}

class NewsList extends StatelessWidget {
  final List<DocumentSnapshot> document;
  ApiService apiService = ApiService();
  NewsList({Key? key, required this.document}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                "${document[index]['coverUrl']}",
                height: 50,
                width: 50,
              ),
              Text("Nama: " + document[index]['username']),
              Text("Judul: " + document[index]['title']),
              Text("Konten: " + document[index]['content']),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return EditNews(
                              judul: document[index]['title'],
                              konten: document[index]['content'],
                              index: document[index].reference,
                              urlName: document[index]['coverUrl']);
                        },
                      ));
                    },
                    child: Text("Edit"),
                    color: Colors.green,
                  ),
                  RaisedButton(
                    onPressed: () {
                      apiService.deleteNews(document[index].reference,
                          document[index]['coverUrl']);
                    },
                    child: Text("Delete"),
                    color: Colors.red,
                  ),
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
    );
  }
}