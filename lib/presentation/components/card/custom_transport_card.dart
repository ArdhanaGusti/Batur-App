import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:theme/theme.dart';

class CustomTransportCard extends StatelessWidget {
  final String img;
  final String title;
  final String route;
  final String time;
  final Function() onTap;
  const CustomTransportCard({
    Key? key,
    required this.img,
    required this.title,
    required this.route,
    required this.time,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 80.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
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
                    width: 60.0,
                    height: 60.0,
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
                      Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: bSubtitle4,
                      ),
                      Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            "assets/icon/fill/map-marker.svg",
                            color: bGrey,
                            height: 14.0,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Flexible(
                            child: Text(
                              route,
                              style: bCaption1.copyWith(color: bGrey),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      Row(
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
                              time,
                              style: bCaption1.copyWith(color: bGrey),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
