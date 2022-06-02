import 'package:flutter/material.dart';
import 'package:theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardWisata extends StatelessWidget {
  const CardWisata({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width - 60;
    return BlocBuilder<ThemeManagerBloc, ThemeManagerState>(
        builder: (context, state) {
      Brightness screenBrightness = MediaQuery.platformBrightnessOf(context);
      var isFavourited = false;
      return Center(
        child: GestureDetector(
          onTap: () {
            print("Container clicked");
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
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
                            'https://akcdn.detik.net.id/visual/2020/03/12/2049bba1-49a2-4efb-a253-82825d9c1f2d_169.jpeg?w=650',
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
                            "Gedung Sate",
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
                                "4,5",
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
                                  ? bPrimary
                                  : (state.isDark == ThemeModeEnum.lightTheme)
                                      ? bPrimary
                                      : (screenBrightness == Brightness.light)
                                          ? bPrimary
                                          : bPrimary,
                              shape: BoxShape.circle),
                          child: Center(
                            child: Icon(
                              Icons.favorite_border,
                              color: bTextPrimary,
                              size: 20,
                            ),
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
                    "Lorem ipsum It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
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
