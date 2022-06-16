import 'package:flutter/material.dart';
import 'package:theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CustomCardDetailStasiun extends StatelessWidget {
  final String img;
  final String telephone;
  final String title;
  final String like;
  final String address;
  final String description;
  final Function() onTap;

  const CustomCardDetailStasiun(
      {Key? key,
      required this.img,
      required this.telephone,
      required this.title,
      required this.like,
      required this.address,
      required this.description,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width - 40;
    List carouselImages = [
      'assets/splashscreen/image1.webp',
      'assets/splashscreen/image1.webp',
    ];
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
      return Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: width,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
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
                      offset: Offset(0, 0),
                    ),
                  ]),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width - 30,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          viewportFraction: 1,
                          enlargeCenterPage: true,
                          autoPlay: true,
                        ),
                        items: carouselImages.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      i,
                                      fit: BoxFit.cover,
                                    )),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: width - 50,
                          child: Text(
                            title,
                            maxLines: 2,
                            style: bHeading7.copyWith(
                              color: (isLight) ? bPrimary : bTextPrimary,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Icon(
                              Icons.thumb_up,
                              color: (isLight) ? bPrimary : bTextPrimary,
                              size: 20,
                            ),
                            Text(
                              like,
                              style: bCaption1,
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      description,
                      style: bCaption1,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: width - 50,
                      child: Text(
                        address,
                        maxLines: 1,
                        style: bCaption1,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.call,
                          color: (isLight) ? bPrimary : bTextPrimary,
                          size: 11,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: width - 50,
                          child: Text(
                            telephone,
                            maxLines: 1,
                            style: bCaption1,
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
        ],
      );
    });
  }
}
