import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:theme/theme.dart';

class CustomTourCardList extends StatelessWidget {
  final String img;
  final String rating;
  final String title;
  final String timeOpen;
  final bool isFavourited;
  final String description;
  final Function() onTap;
  final Function() heartTap;
  const CustomTourCardList({
    Key? key,
    required this.img,
    required this.rating,
    required this.title,
    required this.timeOpen,
    required this.isFavourited,
    required this.description,
    required this.onTap,
    required this.heartTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width - 40.0;

    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: width,
          height: 80.0,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(7.0),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl: img,
                      placeholder: (context, url) {
                        return Center(
                          child: LoadingAnimationWidget.horizontalRotatingDots(
                            color: Theme.of(context).colorScheme.tertiary,
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
                    Container(
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5.0),
                          topRight: Radius.circular(5.0),
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            "assets/icon/fill/star.svg",
                            color: bSecondary,
                            height: 13.0,
                          ),
                          const SizedBox(
                            width: 2.0,
                          ),
                          Text(
                            rating,
                            style: bCaption2.copyWith(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: bSubtitle2.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    const SizedBox(
                      height: 3.0,
                    ),
                    Text(
                      description,
                      style: bCaption1.copyWith(color: bGrey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SvgPicture.asset(
                          "assets/icon/fill/clock.svg",
                          color: bSecondary,
                          height: 15.0,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Flexible(
                          child: Text(
                            timeOpen,
                            style: bCaption1.copyWith(color: bSecondary),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  // Use to save data in Firebase
                },
                child: (isFavourited)
                    ? GestureDetector(
                        onTap: heartTap,
                        child: SvgPicture.asset(
                          "assets/icon/fill/heart.svg",
                          color: bError,
                          height: 20.0,
                        ),
                      )
                    : GestureDetector(
                        onTap: heartTap,
                        child: SvgPicture.asset(
                          "assets/icon/regular/heart.svg",
                          color: bGrey,
                          height: 20.0,
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
