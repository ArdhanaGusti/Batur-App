import 'dart:async';

import 'package:core/presentation/components/appbar/custom_sliver_appbar_text_leading_action.dart';
import 'package:core/presentation/screens/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tourism/presentation/components/custom_tour_card_map.dart';
import 'package:tourism/presentation/screens/tour_detail_screen.dart';
import 'package:tourism/presentation/screens/tour_list_screen.dart';

import '../../data/datasource/tourism_remote_data_source.dart';

enum TourMapScreenProcessEnum {
  loading,
  loaded,
  failed,
}

class TourMapScreen extends StatefulWidget {
  const TourMapScreen({Key? key}) : super(key: key);

  @override
  State<TourMapScreen> createState() => _TourMapScreenState();
}

class _TourMapScreenState extends State<TourMapScreen> {
  // State for click a custom marker
  bool isTour = true;
  bool isClickTour = false;
  String name = "";
  double rating = 0;
  String image = "";
  String openNow = "";
  String placeId = "";

  // State for loading
  TourMapScreenProcessEnum process = TourMapScreenProcessEnum.loading;

  final LatLng _center = const LatLng(-6.905977, 107.613144);

  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final touristAttraction =
        await TourismRemoteDataSource().getTouristAttraction();
    setState(() {
      _markers.clear();
      for (final place in touristAttraction.results) {
        final marker = Marker(
            markerId: MarkerId(place.placeId),
            position: LatLng(
                place.geometry.location.lat, place.geometry.location.lng),
            infoWindow: InfoWindow(
              title: place.name,
              snippet: place.vicinity,
            ),
            onTap: () {
              setState(() {
                // Change state value for click Train
                isClickTour = false;
              });

              setState(() {
                placeId = place.placeId;
                name = place.name;
                rating = place.rating;
                // image = place.photos.;
                if (place.openingHours?.openNow != null) {
                  if (place.openingHours?.openNow == true) {
                    openNow = "Buka";
                  } else {
                    openNow = "Tutup";
                  }
                } else {
                  openNow = "Tidak tahu";
                }
              });

              Timer(const Duration(milliseconds: 500), () {
                setState(() {
                  isTour = true;
                  isClickTour = !isClickTour;
                });
              });
            }
      );
        _markers[place.name] = marker;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      setState(() {
        process = TourMapScreenProcessEnum.loaded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (process == TourMapScreenProcessEnum.loading) {
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
    } else if (process == TourMapScreenProcessEnum.failed) {
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
      title: "Wisata",
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
            child: const TourListScreen(),
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
                      child: SizedBox(
                        height: screenSize.height - 130.0,
                        child: GoogleMap(
                          onMapCreated: _onMapCreated,
                          initialCameraPosition: CameraPosition(
                            target: _center,
                            zoom: 11.0,
                          ),
                          markers: _markers.values.toSet(),
                        ),
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
                        rating: rating.toString(),
                        title: name,
                        timeOpen: openNow,
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
                              child: TourDetailScreen(id: placeId),
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
