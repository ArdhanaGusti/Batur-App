import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:theme/theme.dart';
import 'package:transportation/presentation/screens/gallery_screen.dart';

// Check

class CustomFirstContainerDetail extends StatelessWidget {
  final String title;
  final String address;
  final String telephone;
  final String rating;
  final double width;
  final Function() onTap;
  final List<String> carouselImages;
  final List<String> reviews;
  const CustomFirstContainerDetail({
    Key? key,
    required this.title,
    required this.address,
    required this.telephone,
    required this.rating,
    required this.width,
    required this.onTap,
    required this.carouselImages,
    required this.reviews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: width,
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
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
              CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 1.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                ),
                items: carouselImages.map(
                  (i) {
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
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: CachedNetworkImage(
                                  imageUrl: i,
                                  placeholder: (context, url) {
                                    return Center(
                                      child: LoadingAnimationWidget
                                          .horizontalRotatingDots(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
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
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ).toList(),
              ),
              const SizedBox(
                height: 15.0,
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
                          style: bHeading7.copyWith(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          address,
                          style: bCaption1.copyWith(
                            color: bGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      SvgPicture.asset(
                        "assets/icon/fill/star.svg",
                        color: bSecondary,
                        height: 24.0,
                      ),
                      Text(
                        rating,
                        style: bCaption1.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              Text(
                "Review",
                style: bHeading7.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 1.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  height: 100,
                ),
                items: reviews.map(
                  (i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Text(
                          i,
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                          style: bCaption1.copyWith(
                            color: bGrey,
                          ),
                        );
                      },
                    );
                  },
                ).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
