import 'dart:async';

import 'package:core/presentation/components/appbar/custom_sliver_appbar_text_leading_action.dart';
import 'package:core/presentation/screens/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tourism/presentation/components/custom_tour_card_map.dart';
import 'package:tourism/presentation/screens/tour_detail_screen.dart';
import 'package:tourism/presentation/screens/tour_list_screen.dart';
import 'package:umkm/presentation/screen/umkm_screen.dart';

enum UmkmMapsScreenProcessEnum {
  loading,
  loaded,
  failed,
}

class UmkmMapsScreen extends StatefulWidget {
  const UmkmMapsScreen({Key? key}) : super(key: key);

  @override
  State<UmkmMapsScreen> createState() => _UmkmMapsScreenState();
}

class _UmkmMapsScreenState extends State<UmkmMapsScreen> {
  // State for click a custom marker
  bool isTour = true;
  bool isClickTour = false;

  // State for loading
  UmkmMapsScreenProcessEnum process = UmkmMapsScreenProcessEnum.loading;

  @override
  void initState() {
    super.initState();

    if (mounted) {
      setState(() {
        process = UmkmMapsScreenProcessEnum.loaded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (process == UmkmMapsScreenProcessEnum.loading) {
      return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            _buildAppBar(),
          ];
        },
        body: Scaffold(
          body: Center(
            child: LoadingAnimationWidget.horizontalRotatingDots(
              color: Theme.of(context).colorScheme.tertiary,
              size: 50.0,
            ),
          ),
        ),
      );
    } else if (process == UmkmMapsScreenProcessEnum.failed) {
      return const ErrorScreen(
        title: "AppLocalizations.of(context)!.oops",
        message: "Failed",
      );
    } else {
      return _buildScreen(context, screenSize);
    }
  }

  Widget _buildAppBar() {
    return CustomSliverAppBarTextLeadingAction(
      // Text wait localization
      title: "UMKM",
      leadingIcon: "assets/icon/regular/chevron-left.svg",
      leadingOnTap: () {
        Navigator.pop(
          context,
        );
      },
      actionIcon: "assets/icon/regular/menu.svg",
      actionOnTap: () {
        Navigator.push(
          context,
          PageTransition(
            curve: Curves.easeInOut,
            type: PageTransitionType.rightToLeftJoined,
            childCurrent: widget,
            child: const UmkmScreen(),
          ),
        );
      },
    );
  }

  Widget _buildScreen(BuildContext context, Size screenSize) {
    if (screenSize.width < 300.0 || screenSize.height < 600.0) {
      return const ErrorScreen(
        // Text wait localization
        title: "AppLocalizations.of(context)!.oops",
        message: "AppLocalizations.of(context)!.screenSmall",
      );
    } else {
      // Mobile Mode
      return Scaffold(
        body: _buildLoaded(context, screenSize),
      );
    }
  }

  Widget _buildLoaded(BuildContext context, Size screenSize) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        _buildAppBar(),
        SliverToBoxAdapter(
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          // Change state value for click Train
                          isClickTour = false;
                        });
                        Timer(const Duration(seconds: 1), () {
                          setState(() {
                            isTour = true;
                            isClickTour = !isClickTour;
                          });
                        });
                      },
                      // Change the widget becarefull with height
                      child: Image.asset(
                        "assets/splashscreen/map.jpg",
                        fit: BoxFit.cover,
                        height: screenSize.height - 125.0,
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    bottom: (isClickTour) ? 0 : -120.0,
                    curve: Curves.easeInOut,
                    duration: const Duration(milliseconds: 200),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      // Add parameter for card with data
                      child: CustomTourCard(
                        image:
                            "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                        rating: "4.5",
                        title: "Teko Hias",
                        timeOpen: "Buka (07.00 WIB -16.00 WIB)",
                        isFavourited: true,
                        description:
                            "Lorem ipsum It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              curve: Curves.easeInOut,
                              type: PageTransitionType.bottomToTop,
                              // Navigate to detail with parameter
                              child: const TourDetailScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
