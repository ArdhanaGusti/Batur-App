import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:theme/theme.dart';

class CustomUMKMCard extends StatelessWidget {
  final String img;
  final String title;
  final bool isFavourited;
  final String description;
  final Function() onTap;
  final Function() onHeartTap;
  const CustomUMKMCard({
    Key? key,
    required this.img,
    required this.title,
    required this.isFavourited,
    required this.description,
    required this.onTap,
    required this.onHeartTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 220.0,
          width: 160.0,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 100.0,
                  child: Stack(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        // Still Have an error if image does right
                        child: CachedNetworkImage(
                          imageUrl: img,
                          placeholder: (context, url) {
                            return Center(
                              child:
                                  LoadingAnimationWidget.horizontalRotatingDots(
                                color: Theme.of(context).colorScheme.tertiary,
                                size: 10.0,
                              ),
                            );
                          },
                          errorWidget: (context, url, error) =>
                              SvgPicture.asset(
                            "assets/icon/fill/exclamation-circle.svg",
                            color: bGrey,
                            height: 14.0,
                          ),
                          fit: BoxFit.cover,
                          height: 85.0,
                        ),
                      ),
                      Positioned(
                        top: 70.0,
                        left: 100.0,
                        child: Container(
                          width: 30.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.tertiary,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: isFavourited == true
                                ? GestureDetector(
                                    // Add on Tap
                                    onTap: onHeartTap,
                                    child: SvgPicture.asset(
                                      "assets/icon/fill/heart.svg",
                                      color: bError,
                                      height: 20.0,
                                    ),
                                  )
                                : GestureDetector(
                                    // Add on Tap
                                    onTap: onHeartTap,
                                    child: SvgPicture.asset(
                                      "assets/icon/regular/heart.svg",
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondaryContainer,
                                      height: 20.0,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  title,
                  style: bSubtitle4,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  description,
                  style: bCaption1,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
