import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:transportation/presentation/components/custom_card_transportation.dart';
import 'package:transportation/presentation/screens/transportation_list_screen.dart';
import 'package:transportation/presentation/screens/transportation_detail_screen.dart';

// Check

enum TransportationMapScreenProcessEnum {
  loading,
  loaded,
  failed,
}

class TransportationMapScreen extends StatefulWidget {
  const TransportationMapScreen({Key? key}) : super(key: key);

  @override
  State<TransportationMapScreen> createState() =>
      _TransportationMapScreenState();
}

class _TransportationMapScreenState extends State<TransportationMapScreen> {
  // State for click a custom marker
  bool isTrain = true;
  bool isClickTrain = false;
  bool isClickBus = false;

  // State for loading
  TransportationMapScreenProcessEnum process =
      TransportationMapScreenProcessEnum.loading;

  @override
  void initState() {
    super.initState();

    // Change with to fetch data
    Timer(const Duration(seconds: 3), () {
      // Change state value if data loaded or failed
      setState(() {
        process = TransportationMapScreenProcessEnum.loaded;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (process == TransportationMapScreenProcessEnum.loading) {
      return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
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
    } else if (process == TransportationMapScreenProcessEnum.failed) {
      return const ErrorScreen(
        title: "AppLocalizations.of(context)!.oops",
        message: "AppLocalizations.of(context)!.screenSmall",
      );
    } else {
      return _buildScreen(context, screenSize);
    }
  }

  Widget _buildScreen(BuildContext context, Size screenSize) {
    if (screenSize.width < 300.0 || screenSize.height < 600.0) {
      return const ErrorScreen(
        // Text wait localization
        title: "Eror",
        message: "Eror",
      );
    } else {
      // Mobile Mode
      return Scaffold(
        body: _buildLoaded(context, screenSize),
      );
    }
  }

  Widget _buildAppBar() {
    return CustomSliverAppBarTextLeadingAction(
      // Text wait localization
      title: "Transportasi Umum",
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
            child: const TransportationListScreen(),
            duration: const Duration(milliseconds: 150),
            reverseDuration: const Duration(milliseconds: 150),
          ),
        );
      },
    );
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
                          isClickTrain = false;
                          isClickBus = false;
                        });
                        Timer(const Duration(seconds: 1), () {
                          setState(() {
                            isTrain = true;
                            isClickTrain = !isClickTrain;
                          });
                        });
                      },
                      onDoubleTap: () {
                        setState(() {
                          // Change state value for click Bus
                          isClickBus = false;
                          isClickTrain = false;
                        });
                        Timer(const Duration(seconds: 1), () {
                          setState(() {
                            isTrain = false;
                            isClickBus = !isClickBus;
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
                  (isTrain)
                      ? AnimatedPositioned(
                          bottom: (isClickTrain) ? 0 : -120.0,
                          curve: Curves.easeInOut,
                          duration: const Duration(milliseconds: 200),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            // Add parameter for card with data
                            child: CustomCardStasiun(
                              image:
                                  "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                              title: "Stasiun Bandung Kotaaaaa",
                              description:
                                  "Stasiun Bandung, juga dikenal sebagai Stasiun Hall, adalah stasiun kereta api kelas besar tipe A yang terletak di Jalan Stasiun Timur dan Jalan Kebon Kawung",
                              address:
                                  "Jl. Stasiun Barat, Kb. Jeruk, Kec. Andir, Bandung",
                              rating: '4.7',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    curve: Curves.easeInOut,
                                    type: PageTransitionType.bottomToTop,
                                    // Navigate to detail with parameter
                                    child: const TransportationDetailScreen(
                                      isTrain: true,
                                    ),
                                    duration: const Duration(milliseconds: 150),
                                    reverseDuration:
                                        const Duration(milliseconds: 150),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : AnimatedPositioned(
                          bottom: (isClickBus) ? 0 : -120.0,
                          curve: Curves.easeInOut,
                          duration: const Duration(milliseconds: 200),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            // Add parameter for card with data
                            child: CustomCardStasiun(
                              image:
                                  "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                              title: "Terminal Bandung Kota",
                              description:
                                  "Stasiun Bandung, juga dikenal sebagai Stasiun Hall, adalah stasiun kereta api kelas besar tipe A yang terletak di Jalan Stasiun Timur dan Jalan Kebon Kawung",
                              address:
                                  "Jl. Stasiun Barat, Kb. Jeruk, Kec. Andir, Bandung",
                              rating: '4.7',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    curve: Curves.easeInOut,
                                    type: PageTransitionType.bottomToTop,
                                    // Navigate to detail with parameter
                                    child: const TransportationDetailScreen(
                                      isTrain: false,
                                    ),
                                    duration: const Duration(milliseconds: 150),
                                    reverseDuration:
                                        const Duration(milliseconds: 150),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
