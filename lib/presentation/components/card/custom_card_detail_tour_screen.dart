<<<<<<< HEAD
<<<<<<< HEAD
import 'package:flutter/material.dart';
=======
import 'package:capstone_design/login.dart';
import 'package:capstone_design/presentation/components/custom_app_bar.dart';
import 'package:capstone_design/presentation/components/custom_text_icon_button.dart';
import 'package:capstone_design/presentation/components/custom_validation_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
>>>>>>> 2e96a55 (add tour detail screen)
=======
import 'package:flutter/material.dart';
>>>>>>> 3b0a7ce (add filter tour list screen)
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CustomCardDetailTourScreen extends StatelessWidget {
  final String img;
  final String telephone;
  final String title;
  final String rating;
  final bool isFavourited;
  final String address;
  final String description;
  final Function() onTap;

  const CustomCardDetailTourScreen(
      {Key? key,
      required this.img,
      required this.telephone,
      required this.title,
      required this.rating,
      required this.isFavourited,
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
<<<<<<< HEAD
                      width: width - 30,
                      height: screenSize.height - 600,
=======
                      width: 324,
                      height: 150,
>>>>>>> 2e96a55 (add tour detail screen)
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
<<<<<<< HEAD
<<<<<<< HEAD
                          width: width - 100,
=======
                          width: 270,
>>>>>>> 2e96a55 (add tour detail screen)
=======
                          width: 260,
>>>>>>> 3b0a7ce (add filter tour list screen)
                          child: Text(
                            title,
                            maxLines: 2,
                            style: bHeading7.copyWith(
                              color: (isLight) ? bPrimary : bTextPrimary,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                SvgPicture.asset(
                                  'assets/icon/star.svg',
                                  color: bSecondary,
                                  height: 20,
                                ),
                                Text(rating, style: bCaption1)
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                isFavourited == true
                                    ? GestureDetector(
                                        onTap: () => {},
                                        child: Icon(
                                          Icons.favorite,
                                          color:
                                              (isLight) ? bError : bTextPrimary,
                                          size: 20,
                                        ))
                                    : GestureDetector(
                                        onTap: () => {},
                                        child: Icon(
                                          Icons.favorite_border_outlined,
                                          color: bGrey,
                                          size: 20,
                                        )),
                                Text(
                                  "suka",
                                  style: bCaption1,
                                )
                              ],
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
                    Text(
                      address,
                      maxLines: 1,
                      style: bCaption1,
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
                        Text(
                          telephone,
                          maxLines: 1,
                          style: bCaption1,
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
