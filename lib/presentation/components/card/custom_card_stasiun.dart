import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomCardStasiun extends StatelessWidget {
  final String img;
  final String title;
  final String description;
  final String address;
  final Function() onTap;
  const CustomCardStasiun(
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
    double width = screenSize.width - 70;
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
                      width: 80,
                      height: 80,
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
                        width: 184,
                        child: Text(
                          title,
                          maxLines: 1,
                          style: bSubtitle2.copyWith(color: bTextPrimary),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        children: [
                          SvgPicture.asset(
                            'assets/icon/star.svg',
                            color: bSecondary,
                            height: 15,
                          ),
                          Text("4,5",
                              style: bCaption1.copyWith(color: bTextPrimary))
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: 184,
                    child: Text(
                      description,
                      style: bCaption1.copyWith(
                          color: (isLight) ? bTextPrimary : bGrey),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: bSecondary,
                        size: 15,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 192,
                        height: 10,
                        child: Text(
                          address,
                          style: bCaption1.copyWith(color: bSecondary),
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
