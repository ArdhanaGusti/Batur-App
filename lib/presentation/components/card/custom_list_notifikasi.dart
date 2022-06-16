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
          padding: EdgeInsets.symmetric(
            vertical: 15,
          ),
          width: width,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    img,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
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
                          width: width - 200,
                          child: Text(
                            title,
                            style: bSubtitle2,
                            maxLines: 1,
                          ),
                        ),
                        Container(
                          width: width - 230,
                          child: Text(
                            uploadTime,
                            style: bCaption1,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: width - 60,
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
