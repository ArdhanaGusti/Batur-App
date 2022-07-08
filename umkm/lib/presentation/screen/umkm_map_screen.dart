import 'dart:async';

import 'package:account/account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:umkm/data/service/api_service.dart';
import 'package:umkm/presentation/components/custom_card_umkm.dart';
import 'package:umkm/presentation/screen/umkm_detail_screen.dart';
import 'package:umkm/presentation/screen/umkm_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  User? user = FirebaseAuth.instance.currentUser;
  // State for click a custom marker
  bool isUMKM = true;
  bool isClickUMKM = false;
  String name = "";
  double rating = 0;
  String? image;
  String address = "";
  String desc = "";
  String email = "";
  String placeId = "";
  String web = "";
  String tokped = "";
  String shopee = "";
  String type = "";
  String phone = "";
  DocumentReference? reference;

  // State for loading
  UmkmMapsScreenProcessEnum process = UmkmMapsScreenProcessEnum.loading;

  // Change center to bandung
  final LatLng _center = const LatLng(-6.905977, 107.613144);

  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    QuerySnapshot touristAttraction = await FirebaseFirestore.instance
        .collection("UMKM")
        .where("verification", isEqualTo: true)
        .get();
    setState(() {
      _markers.clear();
      for (final place in touristAttraction.docs) {
        final marker = Marker(
            markerId: MarkerId(place.id),
            position: LatLng(place["latitude"], place["longitude"]),
            onTap: () {
              setState(() {
                isClickUMKM = false;
              });

              setState(() {
                placeId = place.id;
                name = place["name"];
                desc = place["desc"];
                email = place["email"];
                image = place["coverUrl"];
                rating = 0;
                address = place["address"];
                type = place["type"];
                web = place["website"];
                tokped = place["tokped"];
                shopee = place["shopee"];
                phone = place["phone"];
                reference = place.reference;
              });

              Timer(const Duration(milliseconds: 500), () {
                setState(() {
                  isUMKM = true;
                  isClickUMKM = !isClickUMKM;
                });
              });
            });
        _markers[place["name"]] = marker;
      }
    });
  }

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
      return Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              _buildAppBar(),
            ];
          },
          body: Center(
            child: LoadingAnimationWidget.horizontalRotatingDots(
              color: Theme.of(context).colorScheme.tertiary,
              size: 50.0,
            ),
          ),
        ),
      );
    } else if (process == UmkmMapsScreenProcessEnum.failed) {
      return ErrorScreen(
        // Text Wait Localization
        title: AppLocalizations.of(context)!.oops,
        message: AppLocalizations.of(context)!.screenError,
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
      return ErrorScreen(
        // Text wait localization
        title: AppLocalizations.of(context)!.oops,
        message: AppLocalizations.of(context)!.screenSmall,
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
                              isClickUMKM = false;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    bottom: (isClickUMKM) ? 0 : -120.0,
                    curve: Curves.easeInOut,
                    duration: const Duration(milliseconds: 200),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: (user == null)
                            ? FirebaseFirestore.instance
                                .collection("Favorite")
                                .where("umkm", isEqualTo: name)
                                .snapshots()
                            : FirebaseFirestore.instance
                                .collection("Favorite")
                                .where("umkm", isEqualTo: name)
                                .where("email", isEqualTo: user!.email)
                                .where("seller", isEqualTo: email)
                                .snapshots(),
                        builder: (context, fav) {
                          bool favorite = false;
                          if (fav.hasData) {
                            favorite = true;
                          }
                          return CustomCardUMKM(
                            image: (image == null)
                                ? "http://via.placeholder.com/350x150"
                                : image!,
                            title: name,
                            description: desc,
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  curve: Curves.easeInOut,
                                  type: PageTransitionType.rightToLeft,
                                  child: UmkmDetailScreen(
                                    name: name,
                                    email: email,
                                    coverUrl: image!,
                                    address: address,
                                    desc: desc,
                                    index: reference!,
                                    type: type,
                                    noHp: phone,
                                    web: web,
                                    tokped: tokped,
                                    shopee: shopee,
                                  ),
                                ),
                              );
                            },
                            address: address,
                            heartTap: () {
                              if (user == null) {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    curve: Curves.easeInOut,
                                    type: PageTransitionType.bottomToTop,
                                    child: const LoginScreen(),
                                  ),
                                );
                              } else {
                                if (fav.data!.docs.isEmpty) {
                                  ApiServiceUMKM().addFavorite(
                                    image!,
                                    address,
                                    user!.email!,
                                    email,
                                    name,
                                  );
                                } else {
                                  ApiServiceUMKM().removeFavorite(
                                    fav.data!.docs[0].reference,
                                  );
                                }
                              }
                            },
                            isFavourited: favorite,
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
