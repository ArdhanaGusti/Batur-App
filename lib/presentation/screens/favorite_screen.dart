import 'dart:async';

import 'package:capstone_design/presentation/components/appbar/custom_sliver_appbar_dashboard.dart';
import 'package:capstone_design/presentation/components/card/custom_favorite_tour_card.dart';
import 'package:capstone_design/presentation/components/card/custom_favorite_umkm_card.dart';
import 'package:capstone_design/presentation/screens/error_screen.dart';
import 'package:capstone_design/presentation/screens/notifikasi/notifikasi_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:theme/theme.dart';

enum ScreenProcessEnum {
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
  ScreenProcessEnum process = ScreenProcessEnum.loading;
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
    Timer(const Duration(seconds: 3), () {
      setState(() {
        process = ScreenProcessEnum.loaded;
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
    if (process == ScreenProcessEnum.loading) {
      return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
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
      );
    } else if (process == ScreenProcessEnum.failed) {
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
        title: "Error Layar",
        message: "Aduh, Layar anda terlalu kecil",
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
        Navigator.push(
          context,
          PageTransition(
            curve: Curves.easeInOut,
            type: PageTransitionType.rightToLeft,
            child: const NotifikasiScreen(),
            duration: const Duration(milliseconds: 150),
            reverseDuration: const Duration(milliseconds: 150),
          ),
        );
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
        return [
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
              children: [
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
                              // Use Data News
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
                                  onTap: () {},
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
                              // Use Data News
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
                                  onTap: () {},
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

class CustomSmartRefresh extends StatelessWidget {
  final RefreshController refreshController;
  final Function() onRefresh;
  final Function() onLoading;
  final Widget child;
  const CustomSmartRefresh({
    Key? key,
    required this.refreshController,
    required this.onRefresh,
    required this.onLoading,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      onRefresh: onRefresh,
      onLoading: onLoading,
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
        refreshingText: "Memperbarui...",
        releaseText: "Lepas untuk memperbarui",
        idleText: "Tarik kebawah untuk memperbarui",
        failedText: "Gagal memperbarui",
        completeText: "Selesai memperbarui",
        textStyle: bBody1.copyWith(
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
      child: child,
    );
  }
}
