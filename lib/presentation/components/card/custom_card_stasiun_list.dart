import 'package:flutter/material.dart';
import 'package:theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomCardStasiunList extends StatelessWidget {
  final String img;
  final String title;
  final String description;
  final String address;
  final Function() onTap;
  const CustomCardStasiunList(
      {Key? key,
      required this.img,
      required this.title,
      required this.description,
      required this.address,
      required this.onTap})
      : super(key: key);

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
            padding: EdgeInsets.all(10),
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: (state.isDark == ThemeModeEnum.darkTheme)
                  ? bDarkGrey
                  : (state.isDark == ThemeModeEnum.lightTheme)
                      ? bPrimary
                      : (screenBrightness == Brightness.light)
                          ? bPrimary
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
                        width: 225,
                        child: Text(
                          title,
                          style: TextStyle(
                              color: bTextPrimary,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.star,
                            color: bSecondary,
                            size: 14,
                          ),
                          Text("4,5",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10))
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 184,
                    child: Text(
                      description,
                      style: TextStyle(
                          color: (state.isDark == ThemeModeEnum.darkTheme)
                              ? bGrey
                              : (state.isDark == ThemeModeEnum.lightTheme)
                                  ? bTextPrimary
                                  : (screenBrightness == Brightness.light)
                                      ? bTextPrimary
                                      : bGrey,
                          fontSize: 10),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: bSecondary,
                        size: 14,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 192,
                        height: 10,
                        child: Text(
                          address,
                          style: TextStyle(color: bSecondary, fontSize: 10),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  )
                ],
              )
            ]),
          ),
        ),
      );
    });
  }
}
