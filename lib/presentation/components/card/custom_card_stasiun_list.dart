import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      bool isLight = (state.isDark == ThemeModeEnum.darkTheme)
          ? false
          : (state.isDark == ThemeModeEnum.lightTheme)
              ? true
              : (screenBrightness == Brightness.light)
                  ? true
                  : false;
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
                      fit: BoxFit.cover,
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
                        width: 242,
                        child: Text(title,
                            style: bSubtitle2.copyWith(
                                color: (isLight)
                                    ? bPrimaryVariant1
                                    : bTextPrimary)),
                      ),
                      Column(
                        children: [
                          SvgPicture.asset(
                            'assets/icon/star.svg',
                            color: bSecondary,
                            height: 15,
                          ),
                          Text("4,5", style: bCaption1)
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: 250,
                    child: Text(
                      description,
                      style: TextStyle(color: bGrey, fontSize: 10),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
                          style: bCaption2.copyWith(
                              color: (isLight) ? bGrey : bGrey),
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
