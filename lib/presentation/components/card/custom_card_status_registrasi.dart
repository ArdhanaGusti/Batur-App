import 'package:flutter/material.dart';
import 'package:theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardStatusRegistrasi extends StatelessWidget {
  final String img;
  final String title;
  final bool validasi;
  final String time;
  final Function() onTap;
  const CardStatusRegistrasi({
    Key? key,
    required this.img,
    required this.title,
    required this.validasi,
    required this.time,
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: screenSize.width - 210,
                              child: Text(
                                title,
                                style: bSubtitle4,
                                maxLines: 1,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: (validasi == true) ? bAccepted : bError,
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
                                (validasi == true)
                                    ? Icon(
                                        Icons.check_circle,
                                        size: 12,
                                        color: bTextPrimary,
                                      )
                                    : Icon(
                                        Icons.cancel_rounded,
                                        size: 12,
                                        color: bTextPrimary,
                                      ),
                                SizedBox(
                                  width: 3,
                                ),
                                (validasi == true)
                                    ? Text(
                                        "Accepted",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      )
                                    : Text(
                                        "Rejected",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      ),
                              ]),
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
                              width: screenSize.width - 150,
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
