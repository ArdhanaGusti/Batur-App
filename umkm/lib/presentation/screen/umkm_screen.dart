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

import 'add_umkm_screen.dart';
import 'package:geocoding/geocoding.dart';

enum ScreenProcessEnum {
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
  String? address;
  ScreenProcessEnum process = ScreenProcessEnum.loading;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.loadComplete();
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
        process = ScreenProcessEnum.loaded;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (process == ScreenProcessEnum.loading) {
      return Scaffold(
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
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
        ),
      );
    } else if (process == ScreenProcessEnum.failed) {
      return ErrorScreen(
        title: "AppLocalizations.of(context)!.internetConnection",
        message: "AppLocalizations.of(context)!.tryAgain",
      );
    } else {
      return _buildLoaded(context);
    }
  }

  Widget _buildLoaded(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    User user = FirebaseAuth.instance.currentUser!;

    if (screenSize.width < 300.0 || screenSize.height < 600.0) {
      return ErrorScreen(
        title: AppLocalizations.of(context)!.screenError,
        message: AppLocalizations.of(context)!.screenSmall,
      );
    } else if (screenSize.width > 500.0) {
      // Tablet Mode (Must be repair)
      return Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500.0),
          child: _buildUmkmScreen(context, screenSize, user),
        ),
      );
    } else {
      // Mobile Mode
      return _buildUmkmScreen(context, screenSize, user);
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
      isDoubleAction: true,
    );
  }

  Widget _buildUmkmScreen(BuildContext context, Size screenSize, User user) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              _buildAppBar(),
            ];
          },
          body: SmartRefresher(
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            header: ClassicHeader(
              refreshingIcon: LoadingAnimationWidget.horizontalRotatingDots(
                color: Theme.of(context).colorScheme.tertiary,
                size: 20.0,
              ),
              failedIcon: SvgPicture.asset(
                "assets/icon/fill/exclamation-circle.svg",
                color: Theme.of(context).colorScheme.tertiary,
                height: 20.0,
              ),
              completeIcon: SvgPicture.asset(
                "assets/icon/fill/check-circle.svg",
                color: Theme.of(context).colorScheme.tertiary,
                height: 20.0,
              ),
              releaseIcon: SvgPicture.asset(
                "assets/icon/fill/chevron-circle-up.svg",
                color: Theme.of(context).colorScheme.tertiary,
                height: 20.0,
              ),
              idleIcon: SvgPicture.asset(
                "assets/icon/fill/chevron-circle-down.svg",
                color: Theme.of(context).colorScheme.tertiary,
                height: 20.0,
              ),
              refreshingText: "AppLocalizations.of(context)!.refreshingText",
              releaseText: "AppLocalizations.of(context)!.releaseText",
              idleText: "AppLocalizations.of(context)!.idleText",
              failedText: "AppLocalizations.of(context)!.failedText",
              completeText: "AppLocalizations.of(context)!.completeText",
              textStyle: bBody1.copyWith(
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverPadding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    top: 15.0,
                    bottom: 15.0,
                  ),
                  sliver: SliverFillRemaining(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("UMKM")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child:
                                  LoadingAnimationWidget.horizontalRotatingDots(
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
                                            isEqualTo: snapshot
                                                .data!.docs[index]['name'])
                                        .where("email", isEqualTo: user.email)
                                        .snapshots(),
                                    builder: (context, duar) {
                                      return CustomUMKMCardList(
                                        img:
                                            '${snapshot.data!.docs[index]['coverUrl']}',
                                        title: snapshot.data!.docs[index]
                                            ['name'],
                                        timeOpen: "08:00 s/d 16:00",
                                        isFavourited: (duar.data!.docs.isEmpty)
                                            ? false
                                            : true,
                                        description: snapshot.data!.docs[index]
                                            ['address'],
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              curve: Curves.easeInOut,
                                              type: PageTransitionType
                                                  .rightToLeft,
                                              child: UmkmDetailAccScreen(
                                                name: snapshot.data!.docs[index]
                                                    ['name'],
                                                coverUrl: snapshot.data!
                                                    .docs[index]['coverUrl'],
                                                address: snapshot.data!
                                                    .docs[index]['address'],
                                                desc: snapshot.data!.docs[index]
                                                    ['desc'],
                                                index: snapshot.data!
                                                    .docs[index].reference,
                                              ),
                                              duration: const Duration(
                                                  milliseconds: 150),
                                              reverseDuration: const Duration(
                                                  milliseconds: 150),
                                            ),
                                          );
                                        },
                                        heartTap: () {
                                          if (duar.data!.docs.isEmpty) {
                                            ApiServiceUMKM().addFavorite(
                                                snapshot.data!.docs[index]
                                                    ['coverUrl'],
                                                snapshot.data!.docs[index]
                                                    ['address'],
                                                snapshot.data!.docs[index]
                                                    ['email'],
                                                "",
                                                snapshot.data!.docs[index]
                                                    ['name']);
                                          } else {
                                            ApiServiceUMKM().removeFavorite(
                                                duar.data!.docs[0].reference);
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
