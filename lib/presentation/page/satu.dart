import 'dart:io';
import 'package:capstone_design/presentation/page/news/add_news.dart';
import 'package:capstone_design/presentation/page/news/news.dart';
import 'package:capstone_design/presentation/page/profile/profile.dart';
import 'package:capstone_design/presentation/page/umkm/add_umkm.dart';
import 'package:capstone_design/presentation/page/umkm/umkm.dart';
import 'package:flutter/material.dart';

File? image;
String? imageName, judul, konten, urlName;

class Satu extends StatelessWidget {
  Satu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Halaman Satu"),
            Hero(
              tag: "change",
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return AddNews();
                      },
                    ));
                  },
                  child: Text("add News")),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return UMKM();
                    },
                  ));
                },
                child: Text("UMKM")),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return News();
                  },
                ));
              },
              child: Text("News"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return AddUmkm();
                  },
                ));
              },
              child: Text("Add UMKM"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return Profile();
                  },
                ));
              },
              child: Text("Profile"),
            ),
          ],
        ),
      ),
    );
  }
}