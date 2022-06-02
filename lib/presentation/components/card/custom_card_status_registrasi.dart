import 'package:flutter/material.dart';
import 'package:theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardStatusRegistrasi extends StatelessWidget {
  final String img;
  final String title;
  final String validasi;
  final String time;
  const CardStatusRegistrasi({
    Key? key,
    required this.img,
    required this.title,
    required this.validasi,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width - 60;
    return BlocBuilder<ThemeManagerBloc, ThemeManagerState>(
        builder: (context, state) {
      Brightness screenBrightness = MediaQuery.platformBrightnessOf(context);
      return Center(
        child: Column(
          children: [
            Container(
              width: width,
              child: GestureDetector(
                onTap: () {
                  print("Container clicked");
                },
                child: Container(
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
                        width: 60,
                        height: 60,
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
                              width: 175,
                              child: Text(
                                title,
                                style: bSubtitle4,
                              ),
                            ),
                            GestureDetector(
                              child: Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: bAccepted,
                                  boxShadow: [
                                    BoxShadow(
                                      color: bStroke,
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      offset: Offset(
                                          0, 0), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Row(children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Icon(
                                      Icons.check,
                                      size: 12,
                                      color: bAccepted,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    validasi,
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  )
                                ]),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Colors.grey,
                              size: 10,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: 192,
                              child: Text(
                                time,
                                style: bCaption1,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    )
                  ]),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
