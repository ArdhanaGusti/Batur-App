import 'package:flutter/material.dart';
import 'package:theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardTransmetro extends StatelessWidget {
  final String img;
  final String title;
  final String rute;
  final String time;
  final Function() onTap;
  const CardTransmetro({
    Key? key,
    required this.img,
    required this.title,
    required this.rute,
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
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
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
                        width: width - 90,
                        child: Text(
                          title,
                          maxLines: 1,
                          style: TextStyle(
                              color: (state.isDark == ThemeModeEnum.darkTheme)
                                  ? bTextPrimary
                                  : (state.isDark == ThemeModeEnum.lightTheme)
                                      ? bTextSecondary
                                      : (screenBrightness == Brightness.light)
                                          ? bTextSecondary
                                          : bTextPrimary,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: bGrey,
                        size: 14,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: width - 110,
                        child: Text(
                          rute,
                          style: bCaption1.copyWith(
                            color: bGrey,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: bGrey,
                        size: 14,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: width - 110,
                        child: Text(
                          time,
                          style: TextStyle(color: bGrey, fontSize: 10),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ],
              )
            ]),
          ),
        ),
      );
    });
  }
}
