import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:theme/theme.dart';

// Review Check 1 (Done)

class CustomProfileCard extends StatelessWidget {
  final String name;
  final String username;
  final String email;
  final String profilePic;
  const CustomProfileCard({
    Key? key,
    required this.name,
    required this.username,
    required this.email,
    required this.profilePic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.0,
      color: Theme.of(context).colorScheme.surface,
      child: Stack(
        children: <Widget>[
          SizedBox(
            height: 180.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    "assets/logo/logo_dark.png",
                    height: 25.0,
                  ),
                ),
                Image.asset(
                  "assets/image/gd-sate-profile.png",
                  height: 130.0,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            height: 120.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  // Image must repair, still error if invalid URL
                  child: CachedNetworkImage(
                    imageUrl: profilePic,
                    placeholder: (context, url) {
                      return Center(
                        child: LoadingAnimationWidget.horizontalRotatingDots(
                          color: bTextPrimary,
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
                  width: 15.0,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          name,
                          overflow: TextOverflow.ellipsis,
                          style: bSubtitle2.copyWith(
                            color: bTextPrimary,
                          ),
                        ),
                      ),
                      _buildSmallContainer(
                        "assets/icon/regular/user.svg",
                        username,
                      ),
                      _buildSmallContainer(
                        "assets/icon/regular/envelope.svg",
                        email,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildSmallContainer(String icon, String title) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            icon,
            color: bSecondary,
            height: 18.0,
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Text(
              title,
              style: bBody1.copyWith(
                color: bSecondary,
              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
