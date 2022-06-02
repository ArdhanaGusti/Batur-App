import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomWisataCardList extends StatelessWidget {
  final String img;
  final String rating;
  final String title;
  final String timeOpen;
  final bool isFavourited;
  final String description;
  final Function() onTap;
  const CustomWisataCardList({
    Key? key,
    required this.img,
    required this.rating,
    required this.title,
    required this.timeOpen,
    required this.isFavourited,
    required this.description,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width - 60;
    return BlocBuilder<ThemeManagerBloc, ThemeManagerState>(
        builder: (context, state) {
      Brightness screenBrightness = MediaQuery.platformBrightnessOf(context);
      return Center(
        child: GestureDetector(
          onTap: () {
            print("Container clicked");
          },
          child: Container(
            width: width,
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
                child: Stack(
                  children: [
                    Image.network(
                      img,
                      width: 60,
                      height: 60,
                    ),
                    Positioned(
                        bottom: 0,
                        left: 14,
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
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(children: [
                            Icon(
                              Icons.star,
                              color: bSecondary,
                              size: 15,
                            ),
                            Text(
                              rating,
                              style: TextStyle(fontSize: 10),
                            )
                          ]),
                        ))
                  ],
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
                      SizedBox(
                        width: 10,
                      ),
                      isFavourited == true
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
                                color: bError,
                                size: 20,
                              )),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 184,
                    child: Text(
                      description,
                      style: TextStyle(color: bGrey, fontSize: 10),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Icon(
                          Icons.access_time,
                          color: bSecondary,
                          size: 14,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 210,
                        child: Text(
                          timeOpen,
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
