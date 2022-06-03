import 'package:flutter/material.dart';
import 'package:theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListNotifikasi extends StatelessWidget {
  final String img;
  final String title;
  final String uploadTime;
  final String description;
  final Function() onTap;
  const ListNotifikasi({
    Key? key,
    required this.img,
    required this.title,
    required this.uploadTime,
    required this.description,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width - 40;
    return BlocBuilder<ThemeManagerBloc, ThemeManagerState>(
        builder: (context, state) {
      Brightness screenBrightness = MediaQuery.platformBrightnessOf(context);
      return Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              child: Row(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    img,
                    width: 50,
                    height: 50,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Text(title, style: bSubtitle2),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Container(
                          child: Text(
                            uploadTime,
                            style: bCaption1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 250,
                      child: Text(
                        description,
                        style: bSubtitle4,
                      ),
                    ),
                  ],
                )
              ]),
            ),
          ),
        ),
      );
    });
  }
}
