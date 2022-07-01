import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:theme/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CustomCardDetailTourScreen extends StatelessWidget {
  final String img;
  final String telephone;
  final String title;
  final String rating;
  final bool isFavourited;
  final String address;
  final String description;
  final List<String> carouselImages;
  final Function() onTap;

  const CustomCardDetailTourScreen({
    Key? key,
    required this.img,
    required this.telephone,
    required this.title,
    required this.rating,
    required this.isFavourited,
    required this.address,
    required this.description,
    required this.onTap,
    required this.carouselImages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width - 40;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.secondaryContainer,
          boxShadow: const [
            BoxShadow(
              color: bStroke,
              spreadRadius: 2.0,
              blurRadius: 10.0,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: width - 30,
              height: screenSize.height - 600,
              child: CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 1,
                  enlargeCenterPage: true,
                  autoPlay: true,
                ),
                items: carouselImages.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: GestureDetector(
                          onTap: () {},
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: i,
                              placeholder: (context, url) {
                                return Center(
                                  child: LoadingAnimationWidget
                                      .horizontalRotatingDots(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    size: 14.0,
                                  ),
                                );
                              },
                              errorWidget: (context, url, error) => Center(
                                child: SvgPicture.asset(
                                  "assets/icon/fill/exclamation-circle.svg",
                                  color: bGrey,
                                  height: 14.0,
                                ),
                              ),
                              fit: BoxFit.cover,
                              width: 60.0,
                              height: 60.0,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width - 100,
                  child: Text(
                    title,
                    maxLines: 2,
                    style: bHeading7.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
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
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        isFavourited == true
                            ? GestureDetector(
                                onTap: () => {},
                                child: SvgPicture.asset(
                                  "assets/icon/fill/heart.svg",
                                  color: bError,
                                  height: 20.0,
                                ),
                              )
                            : GestureDetector(
                                onTap: () => {},
                                child: SvgPicture.asset(
                                  "assets/icon/regular/heart.svg",
                                  color: Theme.of(context).colorScheme.tertiary,
                                  height: 20.0,
                                ),
                              ),
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
            const SizedBox(
              height: 15,
            ),
            Text(
              description,
              style: bCaption1,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              address,
              maxLines: 1,
              style: bCaption1,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.call,
                  color: Theme.of(context).colorScheme.tertiary,
                  size: 11,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  telephone,
                  maxLines: 1,
                  style: bCaption1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
