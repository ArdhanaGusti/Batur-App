import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:theme/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomNewsCard extends StatelessWidget {
  final String img;
  final String title;
  final String author;
  final String date;

  final Function() onTap;
  const CustomNewsCard({
    Key? key,
    required this.img,
    required this.title,
    required this.author,
    required this.date,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Theme.of(context).colorScheme.secondaryContainer,
          boxShadow: const [
            BoxShadow(
              color: bStroke,
              spreadRadius: 2.0,
              blurRadius: 10.0,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                // Still Have an error if image does right
                child: CachedNetworkImage(
                  imageUrl: img,
                  placeholder: (context, url) {
                    return Center(
                      child: LoadingAnimationWidget.horizontalRotatingDots(
                        color: Theme.of(context).colorScheme.tertiary,
                        size: 10.0,
                      ),
                    );
                  },
                  errorWidget: (context, url, error) => SvgPicture.asset(
                    "assets/icon/fill/exclamation-circle.svg",
                    color: bGrey,
                    height: 14.0,
                  ),
                  fit: BoxFit.cover,
                  width: 85.0,
                  height: 85.0,
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        title,
                        style: bSubtitle4,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.asset(
                                "assets/icon/fill/user.svg",
                                color: bGrey,
                                height: 14.0,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Flexible(
                                child: Text(
                                  author,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: bCaption1.copyWith(color: bGrey),
                                ),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SvgPicture.asset(
                                "assets/icon/fill/clock.svg",
                                color: bGrey,
                                height: 14.0,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Flexible(
                                child: Text(
                                  date,
                                  style: bCaption1.copyWith(color: bGrey),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
