import 'package:flutter/material.dart';
import 'package:theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomNewsCard extends StatelessWidget {
  final String img;
  final String title;
  final String writer;
  final String date;
  const CustomNewsCard({
    Key? key,
    required this.img,
    required this.title,
    required this.writer,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width - 60;
    return Scaffold(body: BlocBuilder<ThemeManagerBloc, ThemeManagerState>(
        builder: (context, state) {
      Brightness screenBrightness = MediaQuery.platformBrightnessOf(context);
      var isFavourited = false;
      return Center(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                print("Container clicked");
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: (state.isDark == ThemeModeEnum.darkTheme)
                      ? bDarkGrey
                      : (state.isDark == ThemeModeEnum.lightTheme)
                          ? bTextPrimary
                          : (screenBrightness == Brightness.light)
                              ? bTextPrimary
                              : bDarkGrey,
                  boxShadow: [
                    BoxShadow(
                      color: bStroke,
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      img,
                      width: 85,
                      height: 85,
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
                            width: 210,
                            child: Text(
                              title,
                              style: bSubtitle4,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.account_circle,
                                color: bGrey,
                                size: 10,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                child: Text(
                                  writer,
                                  style: bCaption2,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                color: bGrey,
                                size: 12,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                child: Text(
                                  date,
                                  style: bCaption2,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                ]),
              ),
            ),
          ],
        ),
      );
    }));
  }
}
