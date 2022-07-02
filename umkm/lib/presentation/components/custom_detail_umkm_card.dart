import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:theme/theme.dart';
import 'package:flutter_svg/svg.dart';
import 'package:umkm/presentation/screen/gallery_screen.dart';

class CustomDetailScreen extends StatelessWidget {
  final String img;
  final String telephone;
  final String title;
  final bool isFavorite;
  final String address;
  final String description;
  final Function() onTap;
  const CustomDetailScreen({
    Key? key,
    required this.img,
    required this.telephone,
    required this.title,
    required this.isFavorite,
    required this.address,
    required this.description,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width - 40.0;

    return Column(
      children: <Widget>[
        Container(
          width: width,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      curve: Curves.easeInOut,
                      type: PageTransitionType.rightToLeft,
                      child: GalleryScreen(
                        images: img,
                        typeNetwork: true,
                      ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CachedNetworkImage(
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
                    width: width - 40.0,
                    height: 200.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      title,
                      maxLines: 2,
                      style: bHeading7.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  (isFavorite)
                      ? GestureDetector(
                          onTap: onTap,
                          child: SvgPicture.asset(
                            "assets/icon/fill/heart.svg",
                            color: bError,
                            height: 20.0,
                          ),
                        )
                      : GestureDetector(
                          onTap: onTap,
                          child: SvgPicture.asset(
                            "assets/icon/regular/heart.svg",
                            color: Colors.grey,
                            height: 20.0,
                          ),
                        ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                description,
                style: bCaption1,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                address,
                maxLines: 2,
                style: bCaption1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  SvgPicture.asset(
                    "assets/icon/regular/phone.svg",
                    color: Colors.grey,
                    height: 14.0,
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Flexible(
                    child: Text(
                      telephone,
                      maxLines: 1,
                      style: bCaption1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
