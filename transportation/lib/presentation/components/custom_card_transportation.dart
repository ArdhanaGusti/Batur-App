import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:theme/theme.dart';

// Check

class CustomCardStasiun extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String address;
  final String rating;
  final Function() onTap;
  const CustomCardStasiun({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
    required this.address,
    required this.rating,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width - 70.0;
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          width: width,
          height: 100.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0),
            color: Theme.of(context).colorScheme.surface,
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
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage(
                  imageUrl: image,
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
                  width: 80.0,
                  height: 80.0,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: bSubtitle2.copyWith(color: bTextPrimary),
                        ),
                        const SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          description,
                          style: bCaption1.copyWith(color: bTextPrimary),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SvgPicture.asset(
                          "assets/icon/fill/map-marker.svg",
                          color: bSecondary,
                          height: 15.0,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Flexible(
                          child: Text(
                            address,
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
              Column(
                children: <Widget>[
                  SvgPicture.asset(
                    "assets/icon/fill/star.svg",
                    color: bSecondary,
                    height: 15.0,
                  ),
                  Text(
                    rating,
                    style: bCaption1.copyWith(color: bTextPrimary),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
