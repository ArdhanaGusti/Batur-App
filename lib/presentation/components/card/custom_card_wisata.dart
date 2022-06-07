import 'package:flutter/material.dart';
import 'package:theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardWisata extends StatelessWidget {
  final String img;
  final String rating;
  final String title;
  final String timeOpen;
  final bool isFavourited;
  final String description;
  final Function() onTap;
  const CardWisata(
      {Key? key,
      required this.img,
      required this.rating,
      required this.title,
      required this.timeOpen,
      required this.isFavourited,
      required this.description,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width - 60;
    return BlocBuilder<ThemeManagerBloc, ThemeManagerState>(
        builder: (context, state) {
      Brightness screenBrightness = MediaQuery.platformBrightnessOf(context);
      return Center(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.only(left: 15, top: 15, bottom: 15),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
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
            child: Column(
              children: [
                Container(
                  child: Stack(children: [
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            img,
                            width: 140,
                            height: 81,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: 140,
                          child: Text(
                            title,
                            style: bSubtitle4,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 5,
                      left: 95,
                      child: Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: (state.isDark == ThemeModeEnum.darkTheme)
                              ? bDarkGrey
                              : (state.isDark == ThemeModeEnum.lightTheme)
                                  ? bTextPrimary
                                  : (screenBrightness == Brightness.light)
                                      ? bTextPrimary
                                      : bDarkGrey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3, vertical: 1),
                              child: Icon(
                                Icons.star,
                                color: bSecondary,
                                size: 15,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 3),
                              child: Text(
                                rating,
                                style: TextStyle(
                                  fontSize: 10,
                                  color:
                                      (state.isDark == ThemeModeEnum.darkTheme)
                                          ? bTextPrimary
                                          : (state.isDark ==
                                                  ThemeModeEnum.lightTheme)
                                              ? bTextSecondary
                                              : (screenBrightness ==
                                                      Brightness.light)
                                                  ? bTextSecondary
                                                  : bTextPrimary,
                                ),
                              ),
                            )
                          ],
                        ),
                      ), //CircularAvatar
                    ),
                    Positioned(
                      top: 65,
                      left: 95,
                      child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: (state.isDark == ThemeModeEnum.darkTheme)
                                  ? bTextPrimary
                                  : (state.isDark == ThemeModeEnum.lightTheme)
                                      ? bPrimary
                                      : (screenBrightness == Brightness.light)
                                          ? bPrimary
                                          : bTextPrimary,
                              shape: BoxShape.circle),
                          child: Center(
                            child: isFavourited == true
                                ? GestureDetector(
                                    onTap: () => {},
                                    child: Icon(
                                      Icons.favorite,
                                      color: bError,
                                      size: 20,
                                    ))
                                : GestureDetector(
                                    onTap: () => {},
                                    child: Icon(
                                      Icons.favorite_border_outlined,
                                      color: (state.isDark ==
                                              ThemeModeEnum.darkTheme)
                                          ? bPrimary
                                          : (state.isDark ==
                                                  ThemeModeEnum.lightTheme)
                                              ? bTextPrimary
                                              : (screenBrightness ==
                                                      Brightness.light)
                                                  ? bTextPrimary
                                                  : bPrimary,
                                      size: 20,
                                    )),
                          )), //CircularAvatar
                    ),
                  ]),
                ),
                SizedBox(
                  height: 5,
                ),

                ///trans Metro Bandung
                Container(
                  width: 140,
                  child: Text(
                    description,
                    style: bCaption1,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
