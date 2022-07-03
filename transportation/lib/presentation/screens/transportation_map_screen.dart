import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:transportation/presentation/components/custom_card_transportation.dart';
import 'package:transportation/presentation/screens/transportation_detail_screen.dart';
import 'package:transportation/presentation/screens/transportation_list_screen.dart';

import '../../data/datasources/transportation_remote_data_source.dart';

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
  List<String> title = [
    "Cimahi",
    "Cicalengka",
    "Padalarang",
    "Haurpugur",
    "Rancaekek",
    "Cimekar",
    "Gedebage",
    "Cikudapateuh",
    "Ciroyom",
    "Stasiun Cimindi",
    "Stasiun Bandung",
    "Kiaracondong"
  ];

  List<String> titleFirebase = [
    "Cimahi",
    "Cicalengka",
    "Padalarang",
    "Haurpugur",
    "Rancaekek",
    "Cimekar",
    "Gedebage",
    "Cikudapateuh",
    "Ciroyom",
    "Cimindi",
    "Bandung",
    "Kiaracondong"
  ];
  // State for click a custom marker
  bool isTrain = true;
  bool isClickTrain = false;
  String titleStation = "";
  String name = "";
  double rating = 0;
  String image = "";
  String placeId = "";
  String address = "";

  // State for loading
  TransportationMapScreenProcessEnum process =
      TransportationMapScreenProcessEnum.loaded;

  // @override
  // void initState() {
  //   super.initState();

  //   // Change with to fetch data
  //   Timer(const Duration(seconds: 3), () {
  //     // Change state value if data loaded or failed
  //     setState(() {
  //       process = TransportationMapScreenProcessEnum.loaded;
  //     });
  //   });
  // }

  final LatLng _center = const LatLng(-6.905977, 107.613144);

  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final station = await TransportationRemoteDataSource().getStation();
    setState(() {
      _markers.clear();
      for (final place in station.results) {
        if (title.contains(place.name)) {
          final marker = Marker(
              markerId: MarkerId(place.placeId),
              position: LatLng(
                  place.geometry.location.lat, place.geometry.location.lng),
              onTap: () {
                setState(() {
                  // Change state value for click Tour
                  isClickTrain = false;
                });

                final indexTitleStation = title.indexOf(place.name);
                setState(() {
                  titleStation = titleFirebase[indexTitleStation];
                  placeId = place.placeId;
                  address = place.vicinity;
                  name = place.name;
                  rating = place.rating;
                  image =
                      "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${place.photos![0].photoReference}&key=AIzaSyAO1b9CLWFz6Y9NG14g2gpYP7TQWPRsPG0";
                });

                Timer(const Duration(milliseconds: 500), () {
                  setState(() {
                    isTrain = true;
                    isClickTrain = !isClickTrain;
                  });
                });
              });
          _markers[place.name] = marker;
        }
      }
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
                        });
                        Timer(const Duration(seconds: 1), () {
                          setState(() {
                            isTrain = true;
                            isClickTrain = !isClickTrain;
                          });
                        });
                      },
                      // Change the widget becarefull with height
                      child: SizedBox(
                        height: screenSize.height - 130.0,
                        child: GoogleMap(
                          onMapCreated: _onMapCreated,
                          initialCameraPosition: CameraPosition(
                            target: _center,
                            zoom: 11.0,
                          ),
                          markers: _markers.values.toSet(),
                          onTap: (latLong) {
                            if (_center != latLong) {
                              setState(() {
                                isClickTrain = false;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    bottom: (isClickTrain) ? 0 : -120.0,
                    curve: Curves.easeInOut,
                    duration: const Duration(milliseconds: 200),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      // Add parameter for card with data
                      child: CustomCardStasiun(
                        image: image,
                        title: name,
                        address: address,
                        rating: rating.toString(),
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              curve: Curves.easeInOut,
                              type: PageTransitionType.bottomToTop,
                              // Navigate to detail with parameter
                              child: TransportationDetailScreen(
                                isTrain: true,
                                station: titleStation,
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
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
