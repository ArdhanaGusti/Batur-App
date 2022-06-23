import 'dart:async';

import 'package:core/presentation/components/appbar/custom_sliver_appbar_dashboard.dart';
import 'package:core/presentation/components/card/custom_favorite_tour_card.dart';
import 'package:core/presentation/components/card/custom_favorite_umkm_card.dart';
import 'package:core/presentation/components/custom_smart_refresh.dart';
import 'package:core/presentation/screens/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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

class _FavoriteScreenState extends State<FavoriteScreen>
    with TickerProviderStateMixin {
  FavScreenProcessEnum process = FavScreenProcessEnum.loading;
  late TabController _controller;

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

  final RefreshController _refreshController2 =
      RefreshController(initialRefresh: false);

  void _onRefresh2() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController2.refreshCompleted();
  }

  void _onLoading2() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController2.loadComplete();
  }

  @override
  void initState() {
    super.initState();

    _controller = TabController(
      vsync: this,
      length: 2,
    );

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
    _controller.dispose();
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
    return CustomSliverAppBarDashboard(
      actionIcon: "assets/icon/regular/bell.svg",
      // Must add on Tap
      actionOnTap: () {
        // Navigate to Notification Page
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
  }

  Widget _buildFavoriteScreen(BuildContext context, Size screenSize) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          _buildAppBar(),
        ];
      },
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 10.0,
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                height: 30.0,
                width: 230.0,
                child: TabBar(
                  controller: _controller,
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
                        "Tour",
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
                    )
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            child: TabBarView(
              physics: const BouncingScrollPhysics(),
              controller: _controller,
              children: <Widget>[
                CustomSmartRefresh(
                  onLoading: _onLoading,
                  onRefresh: _onRefresh,
                  refreshController: _refreshController,
                  child: CustomScrollView(
                    shrinkWrap: true,
                    // physics: const BouncingScrollPhysics(),
                    slivers: <Widget>[
                      SliverPadding(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                          left: 20.0,
                          right: 20.0,
                        ),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              // Use Data Tour
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: CustomFavoriteTourCard(
                                  img:
                                      "https://cdn1-production-images-kly.akamaized.net/lMHji7xE4GI7YHCWAQumKfFm9Ew=/1200x900/smart/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/3554482/original/037161700_1630219411-bandung-5319951_1920.jpg",
                                  title:
                                      "Museum Geologi Bandung Bandung Jawa Barat",
                                  address:
                                      "Jl. Diponegoro No.57, Cihaur Geulis, Kec. Cibeunying Kaler, Kota Bandung, Jawa Barat 40122",
                                  open: "Buka (07:00 WIB -16:00 WIB",
                                  rating: "4,5",
                                  onTap: () {
                                    // Navigate to Tour Detail
                                  },
                                ),
                              );
                            },
                            childCount: 10,
                          ),
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
                      SliverPadding(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                          left: 20.0,
                          right: 20.0,
                        ),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              // Use Data UMKM
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: CustomFavoriteUMKMCard(
                                  img:
                                      "https://cdn1-production-images-kly.akamaized.net/lMHji7xE4GI7YHCWAQumKfFm9Ew=/1200x900/smart/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/3554482/original/037161700_1630219411-bandung-5319951_1920.jpg",
                                  title:
                                      "Museum Geologi Bandung Bandung Jawa Barat",
                                  address:
                                      "Jl. Diponegoro No.57, Cihaur Geulis, Kec. Cibeunying Kaler, Kota Bandung, Jawa Barat 40122",
                                  open: "Buka (07:00 WIB -16:00 WIB",
                                  rating: "4,5",
                                  onTap: () {
                                    // Navigate to UMKM Detail
                                  },
                                ),
                              );
                            },
                            childCount: 4,
                          ),
                        ),
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
}
