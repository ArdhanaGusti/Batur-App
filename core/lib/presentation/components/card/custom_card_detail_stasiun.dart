import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:transportation/presentation/screens/gallery_screen.dart';

class CustomCardDetailStasiun extends StatelessWidget {
  final String imgList;
  final String telephone;
  final String title;
  final String like;
  final String address;
  final String description;
  final Function() onTap;

  const CustomCardDetailStasiun({
    Key? key,
    required this.imgList,
    required this.telephone,
    required this.title,
    required this.like,
    required this.address,
    required this.description,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width - 40;
    List<String> carouselImages = [
      'https://terkinni.com/wp-content/uploads/2022/06/red_velvet-20220322-001-non_fotografer_kly.jpg',
      'https://www.jd.id/news/wp-content/uploads/2022/03/Album-Blackpink-min.jpg',
      'https://img.celebrities.id/okz/900/yE79u7/master_w524V5OHB5_1654_twice.jpg',
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
          children: <Widget>[
            Container(
              width: width,
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.secondaryContainer,
                boxShadow: const [
                  BoxShadow(
                    color: bStroke,
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CarouselSlider(
                    options: CarouselOptions(
                      viewportFraction: 1,
                      enlargeCenterPage: true,
                      autoPlay: true,
                    ),
                    items: carouselImages.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Hero(
                            tag: carouselImages[carouselImages.indexOf(i)],
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GalleryScreen(
                                      images: carouselImages,
                                      index: carouselImages.indexOf(i),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      i,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              title,
                              maxLines: 2,
                              style: bHeading7.copyWith(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              address,
                              style: bCaption1.copyWith(
                                color: bGrey,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.call,
                                  color: bGrey,
                                  size: 11,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Flexible(
                                  child: Text(
                                    telephone,
                                    maxLines: 1,
                                    style: bCaption1,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                SvgPicture.asset(
                                  "assets/icon/regular/copy.svg",
                                  color: bGrey,
                                  height: 14,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          SvgPicture.asset(
                            "assets/icon/fill/star.svg",
                            color: bSecondary,
                            height: 24,
                          ),
                          Text(
                            like,
                            style: bCaption1.copyWith(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
