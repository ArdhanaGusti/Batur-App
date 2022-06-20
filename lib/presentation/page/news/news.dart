import 'package:capstone_design/data/service/api_service.dart';
import 'package:capstone_design/presentation/bloc/news/news_event.dart';
import 'package:capstone_design/presentation/bloc/news/news_remove_bloc.dart';
import 'package:capstone_design/presentation/bloc/news/news_state.dart';
import 'package:capstone_design/presentation/page/dashboard.dart';
import 'package:capstone_design/presentation/page/news/edit_news.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) {
                return Dashboard(user: user!);
              },
            ));
          },
          icon: Icon(Icons.arrow_back_rounded),
        ),
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
                  BlocBuilder<NewsRemoveBloc, NewsState>(
                      builder: (context, state) {
                    return RaisedButton(
                      onPressed: () {
                        context.read<NewsRemoveBloc>().add(OnRemoveNews(
                            document[index]['coverUrl'],
                            document[index].reference));
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
    );
  }
}
