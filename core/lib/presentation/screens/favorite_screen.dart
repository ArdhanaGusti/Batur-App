import 'dart:async';

import 'package:account/account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/presentation/bloc/dashboard_bloc.dart';
import 'package:core/presentation/components/appbar/custom_sliver_appbar_dashboard.dart';
import 'package:core/presentation/components/button/custom_primary_text_button.dart';
import 'package:core/presentation/components/card/custom_favorite_tour_card.dart';
import 'package:core/presentation/components/card/custom_favorite_umkm_card.dart';
import 'package:core/presentation/components/custom_smart_refresh.dart';
import 'package:core/presentation/screens/error_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:theme/theme.dart';

enum FavScreenProcessEnum {
  loading,
  loaded,
  failed,
}

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  FavScreenProcessEnum process = FavScreenProcessEnum.loading;

// Refresh
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  // Refresh
  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  // Refresh
  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  // Refresh
  final RefreshController _refreshController2 =
      RefreshController(initialRefresh: false);

  // Refresh
  void _onRefresh2() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController2.refreshCompleted();
  }

  // Refresh
  void _onLoading2() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController2.loadComplete();
  }

  @override
  void initState() {
    if (user != null) {
      context.read<DashboardBloc>().add(OnIsHaveProfile(email: user!.email!));
    }
    super.initState();

    // Must be repair
    // Change with to fetch data
    Timer(const Duration(seconds: 3), () {
      setState(() {
        // Change state value if data loaded or failed
        process = FavScreenProcessEnum.loaded;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (process == FavScreenProcessEnum.loading) {
      return NestedScrollView(
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
      );
    } else if (process == FavScreenProcessEnum.failed) {
      return const ErrorScreen(
        // Text wait localization
        title: "Koneksi Internet",
        message: "Aduh, Coba lagi nanti",
      );
    } else {
      return _buildLoaded(context);
    }
  }

  Widget _buildLoaded(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 300.0 || screenSize.height < 600.0) {
      return const ErrorScreen(
        // Text wait localization
        title: "Error",
        message: "Error",
      );
    } else if (screenSize.width > 500.0) {
      // Tablet Mode (Must be repair)
      return Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500.0),
          child: _buildFavoriteScreen(context, screenSize),
        ),
      );
    } else {
      // Mobile Mode
      return _buildFavoriteScreen(context, screenSize);
    }
  }

  Widget _buildAppBar() {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return CustomSliverAppBarDashboard(
          actionIcon: "assets/icon/regular/bell.svg",
          // Must add on Tap
          actionOnTap: () {
            if (user != null) {
              if (state.isHaveProfile) {
                Navigator.push(
                  context,
                  PageTransition(
                    curve: Curves.easeInOut,
                    type: PageTransitionType.rightToLeft,
                    child: const NotificationScreen(),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  PageTransition(
                    curve: Curves.easeInOut,
                    type: PageTransitionType.bottomToTop,
                    child: const RegistrationSettingScreen(),
                  ),
                );
              }
            } else {
              Navigator.push(
                context,
                PageTransition(
                  curve: Curves.easeInOut,
                  type: PageTransitionType.bottomToTop,
                  child: const LoginScreen(),
                ),
              );
            }
          },
          leading: const Text(
            // Text wait localization
            "Favorite",
            textAlign: TextAlign.center,
          ),
          actionIconSecondary: "",
          // Must add on Tap
          actionOnTapSecondary: () {},
          // Becarefull with this
          isDoubleAction: false,
        );
      },
    );
  }

  Widget _buildFavoriteScreen(BuildContext context, Size screenSize) {
    return DefaultTabController(
      length: 2, // Length of tabs
      initialIndex: 0,
      child: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: <Widget>[
          _buildAppBar(),
          BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              if (state.isHaveProfile) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        height: 30.0,
                        width: 230.0,
                        child: TabBar(
                          indicator: BoxDecoration(
                            color: Theme.of(context).colorScheme.tertiary,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          splashBorderRadius: BorderRadius.circular(10.0),
                          unselectedLabelColor:
                              Theme.of(context).colorScheme.tertiaryContainer,
                          tabs: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                // Wait Localization
                                "Wisata",
                                style: bSubtitle3,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                // Wait Localization
                                "UMKM",
                                style: bSubtitle3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return const SliverToBoxAdapter(child: SizedBox());
              }
            },
          ),
          SliverFillRemaining(
            child: BlocBuilder<DashboardBloc, DashboardState>(
              builder: (context, state) {
                if (state.isHaveProfile) {
                  return TabBarView(
                    physics: const BouncingScrollPhysics(),
                    children: <Widget>[
                      CustomSmartRefresh(
                        onLoading: _onLoading,
                        onRefresh: _onRefresh,
                        refreshController: _refreshController,
                        child: CustomScrollView(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          slivers: <Widget>[
                            SliverFillRemaining(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 20.0,
                                  left: 20.0,
                                  right: 20.0,
                                ),
                                child: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection("FavoriteTour")
                                        .where('email',
                                            isEqualTo: FirebaseAuth
                                                .instance.currentUser!.email)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return CircularProgressIndicator();
                                      }
                                      return ListView.builder(
                                        itemBuilder: (context, index) {
                                          return CustomFavoriteTourCard(
                                            img: snapshot.data!.docs[index]
                                                ['urlName'],
                                            title: snapshot.data!.docs[index]
                                                ['tour'],
                                            address: snapshot.data!.docs[index]
                                                ['address'],
                                            open: "Buka (07:00 WIB -16:00 WIB",
                                            rating: snapshot
                                                .data!.docs[index]['rating']
                                                .toString(),
                                            onTap: () {
                                              // Navigate to Tour Detail
                                            },
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
                      CustomSmartRefresh(
                        refreshController: _refreshController2,
                        onLoading: _onLoading2,
                        onRefresh: _onRefresh2,
                        child: CustomScrollView(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          slivers: <Widget>[
                            SliverFillRemaining(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 20.0,
                                  left: 20.0,
                                  right: 20.0,
                                ),
                                child: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection("Favorite")
                                        .where('email',
                                            isEqualTo: FirebaseAuth
                                                .instance.currentUser!.email)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return CircularProgressIndicator();
                                      }
                                      return ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          // Use Data UMKM
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 15.0),
                                            child: CustomFavoriteUMKMCard(
                                              img: snapshot.data!.docs[index]
                                                  ['coverUrl'],
                                              title: snapshot.data!.docs[index]
                                                  ['umkm'],
                                              address: snapshot
                                                  .data!.docs[index]['address'],
                                              open:
                                                  "Buka (07:00 WIB -16:00 WIB",
                                              onTap: () {
                                                // Navigate to UMKM Detail
                                              },
                                            ),
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
                    ],
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Anda belum mempunyai profile\nKelik disini untuk registrasi profile",
                          overflow: TextOverflow.ellipsis,
                          style: bSubtitle2.copyWith(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomPrimaryTextButton(
                          width: screenSize.width - 40,
                          // Text wait localization
                          text: "Daftar Profile",
                          onTap: () {},
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
