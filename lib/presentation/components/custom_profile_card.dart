import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';

class CustomProfileCard extends StatelessWidget {
  const CustomProfileCard({Key? key}) : super(key: key);

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
                    'assets/logo/logo_dark.png',
                    height: 25.0,
                  ),
                ),
                Image.asset(
                  'assets/image/gd-sate-profile.png',
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
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  // Image must repair, depands on image
                  child: Image.asset(
                    "assets/image/profile.jpg",
                    height: 80.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          "Neida Aleidaa",
                          overflow: TextOverflow.ellipsis,
                          style: bSubtitle2.copyWith(
                            color: bTextPrimary,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: SvgPicture.asset(
                                "assets/icon/user_outline.svg",
                                color: bSecondary,
                                height: 18.0,
                              ),
                            ),
                            Text(
                              'bandungtourim',
                              style: bBody1.copyWith(
                                color: bSecondary,
                              ),
                              overflow: TextOverflow.fade,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(
                            "assets/icon/envelope.svg",
                            color: bSecondary,
                            height: 18.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              'Batur@gmail.com',
                              style: bBody1.copyWith(
                                color: bSecondary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
