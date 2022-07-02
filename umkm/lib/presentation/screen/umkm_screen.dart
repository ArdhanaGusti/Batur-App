import 'dart:async';

import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:theme/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:umkm/data/service/api_service.dart';
import 'package:umkm/presentation/components/custom_umkm_card_list.dart';
import 'package:umkm/presentation/screen/umkm_detail_acc_screen.dart';
import 'package:umkm/presentation/screen/umkm_detail_screen.dart';

import 'add_umkm_screen.dart';
import 'package:geocoding/geocoding.dart';

enum UmkmListScreenProcessEnum {
  loading,
  loaded,
  failed,
}

class UmkmScreen extends StatefulWidget {
  const UmkmScreen({Key? key}) : super(key: key);

  @override
  State<UmkmScreen> createState() => _UmkmScreenState();
}

class _UmkmScreenState extends State<UmkmScreen> {
  User user = FirebaseAuth.instance.currentUser!;
  TextEditingController controller = TextEditingController();
  String find = '';
  String? address;
  UmkmListScreenProcessEnum process = UmkmListScreenProcessEnum.loading;

  final RefreshController _refreshControllerUMKM =
      RefreshController(initialRefresh: false);

  void _onRefreshTour() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshControllerUMKM.refreshCompleted();
  }

  void _onLoadingTour() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshControllerUMKM.loadComplete();
  }

  Future<void> getAddressFromLatLong(double latitude, double longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placemarks[0];
    address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
  }

  @override
  void initState() {
    super.initState();

    // Must be repair
    Timer(const Duration(seconds: 3), () {
      setState(() {
        process = UmkmListScreenProcessEnum.loaded;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    if (process == UmkmListScreenProcessEnum.loading) {
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
    } else if (process == UmkmListScreenProcessEnum.failed) {
      return ErrorScreen(
        title: "AppLocalizations.of(context)!.internetConnection",
        message: "AppLocalizations.of(context)!.tryAgain",
      );
    } else {
      return _buildSuccess(screenSize);
    }
  }

  Widget _buildSuccess(Size screenSize) {
    if (screenSize.width < 300.0 || screenSize.height < 600.0) {
      return const ErrorScreen(
        // Text wait localization
        title: "Eror",
        message: "Eror",
      );
    } else if (screenSize.width > 500.0) {
      // Mobile Mode
      return Scaffold(
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500.0),
            child: _buildLoaded(screenSize, user),
          ),
        ),
      );
    } else {
      // Mobile Mode
      return Scaffold(
        body: _buildLoaded(screenSize, user),
      );
    }
  }

  Widget _buildAppBar() {
    return CustomSliverAppBarDashboard(
      actionIcon: "assets/icon/regular/bell.svg",
      actionOnTap: () {
        Navigator.push(
          context,
          PageTransition(
            curve: Curves.easeInOut,
            type: PageTransitionType.rightToLeft,
            child: const AddUMKMScreen(),
            duration: const Duration(milliseconds: 150),
            reverseDuration: const Duration(milliseconds: 150),
          ),
        );
      },
      leading: Text(
        AppLocalizations.of(context)!.umkm,
        textAlign: TextAlign.center,
      ),
      actionIconSecondary: "assets/icon/regular/plus-square.svg",
      actionOnTapSecondary: () {
        Navigator.push(
          context,
          PageTransition(
            curve: Curves.easeInOut,
            type: PageTransitionType.rightToLeft,
            child: const AddUMKMScreen(),
            duration: const Duration(milliseconds: 150),
            reverseDuration: const Duration(milliseconds: 150),
          ),
        );
      },
      isDoubleAction: false,
    );
  }

  Widget _buildLoaded(Size screenSize, User user) {
    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: <Widget>[
        _buildAppBar(),
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    width: screenSize.width - 90.0,
                    margin: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.search,
                      ),
                      style: bSubtitle1.copyWith(color: bGrey),
                      onChanged: (text) {
                        setState(() {
                          // Use for Search
                          find = text;
                        });
                      },
                    )),
                Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/icon/regular/search.svg",
                      color: Theme.of(context).colorScheme.tertiary,
                      height: 24.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverFillRemaining(
          child: CustomSmartRefresh(
            refreshController: _refreshControllerUMKM,
            onLoading: _onLoadingTour,
            onRefresh: _onRefreshTour,
            child: Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: StreamBuilder<QuerySnapshot>(
                  stream:
                      FirebaseFirestore.instance.collection("UMKM").snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: LoadingAnimationWidget.horizontalRotatingDots(
                          color: Theme.of(context).colorScheme.tertiary,
                          size: 50.0,
                        ),
                      );
                    }
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        // Use Data News
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("Favorite")
                                  .where("umkm",
                                      isEqualTo: snapshot.data!.docs[index]
                                          ['name'])
                                  .where("email",
                                      isEqualTo: FirebaseAuth
                                          .instance.currentUser!.email)
                                  .snapshots(),
                              builder: (context, fav) {
                                if (!snapshot.hasData) {
                                  return LoadingAnimationWidget
                                      .horizontalRotatingDots(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    size: 50.0,
                                  );
                                }
                                if (fav.data == null) {
                                  return LoadingAnimationWidget
                                      .horizontalRotatingDots(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    size: 50.0,
                                  );
                                }
                                return CustomUMKMCardList(
                                  img:
                                      '${snapshot.data!.docs[index]['coverUrl']}',
                                  title: snapshot.data!.docs[index]['name'],
                                  timeOpen: "08:00 s/d 16:00",
                                  isFavourited:
                                      (fav.data!.docs.isEmpty) ? false : true,
                                  description: snapshot.data!.docs[index]
                                      ['address'],
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        curve: Curves.easeInOut,
                                        type: PageTransitionType.rightToLeft,
                                        child: UmkmDetailScreen(
                                          name: snapshot.data!.docs[index]
                                              ['name'],
                                          coverUrl: snapshot.data!.docs[index]
                                              ['coverUrl'],
                                          address: snapshot.data!.docs[index]
                                              ['address'],
                                          desc: snapshot.data!.docs[index]
                                              ['desc'],
                                          index: snapshot
                                              .data!.docs[index].reference,
                                          type: snapshot.data!.docs[index]
                                              ['desc'],
                                          noHp: snapshot.data!.docs[index]
                                              ['phone'],
                                        ),
                                        duration:
                                            const Duration(milliseconds: 150),
                                        reverseDuration:
                                            const Duration(milliseconds: 150),
                                      ),
                                    );
                                  },
                                  heartTap: () {
                                    if (fav.data!.docs.isEmpty) {
                                      ApiServiceUMKM().addFavorite(
                                          snapshot.data!.docs[index]
                                              ['coverUrl'],
                                          snapshot.data!.docs[index]['address'],
                                          snapshot.data!.docs[index]['email'],
                                          "",
                                          snapshot.data!.docs[index]['name']);
                                    } else {
                                      ApiServiceUMKM().removeFavorite(
                                          fav.data!.docs[0].reference);
                                    }
                                  },
                                );
                              }),
                        );
                      },
                      itemCount: snapshot.data!.docs.length,
                    );
                  }),
            ),
          ),
        ),
      ],
    );
  }
}
