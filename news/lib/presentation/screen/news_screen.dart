import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/presentation/components/appbar/custom_sliver_appbar_dashboard.dart';
import 'package:core/presentation/components/card/custom_news_card.dart';
import 'package:core/presentation/components/card/custom_favorite_umkm_card.dart';
import 'package:core/presentation/components/custom_smart_refresh.dart';
import 'package:core/presentation/screens/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:theme/theme.dart';
import 'package:page_transition/page_transition.dart';
import 'news_detail_screen.dart';
import 'add_news_screen.dart';
import 'package:account/account.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum ScreenProcessEnum {
  loading,
  loaded,
  failed,
}

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with TickerProviderStateMixin {
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
    // Change with to fetch data
    Timer(const Duration(seconds: 3), () {
      setState(() {
        // Change state value if data loaded or failed
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
        title: "Error",
        message: "Error",
      );
    } else if (screenSize.width > 500.0) {
      // Tablet Mode (Must be repair)
      return Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500.0),
          child: _buildNewsScreen(context, screenSize),
        ),
      );
    } else {
      // Mobile Mode
      return _buildNewsScreen(context, screenSize);
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
            child: const NotificationScreen(),
            duration: const Duration(milliseconds: 150),
            reverseDuration: const Duration(milliseconds: 150),
          ),
        );
      },
      leading: Text(
        // Text wait localization
        AppLocalizations.of(context)!.news,
        textAlign: TextAlign.center,
      ),
      actionIconSecondary: "assets/icon/regular/plus-square.svg",
      actionOnTapSecondary: () {
        Navigator.push(
          context,
          PageTransition(
            curve: Curves.easeInOut,
            type: PageTransitionType.rightToLeft,
            child: const AddNewsScreen(),
            duration: const Duration(milliseconds: 150),
            reverseDuration: const Duration(milliseconds: 150),
          ),
        );
      },
      isDoubleAction: true,
    );
  }

  Widget _buildNewsScreen(BuildContext context, Size screenSize) {
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
                        "Terkini",
                        style: bSubtitle3,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        // Wait Localization
                        "News",
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
                        sliver: SliverToBoxAdapter(
                          child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("News")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return CircularProgressIndicator();
                                }
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    // Use Data News
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15.0),
                                      child: CustomNewsCard(
                                        img:
                                            '${snapshot.data!.docs[index]['coverUrl']}',
                                        title: snapshot.data!.docs[index]
                                            ['title'],
                                        writer: snapshot.data!.docs[index]
                                            ['username'],
                                        date: snapshot.data!.docs[index]
                                            ['date'],
                                        onTap: () {
                                          // To detail News
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              curve: Curves.easeOut,
                                              type: PageTransitionType
                                                  .bottomToTop,
                                              child: const NewsDetailScreen(),
                                              duration: const Duration(
                                                  milliseconds: 150),
                                              reverseDuration: const Duration(
                                                  milliseconds: 150),
                                            ),
                                          );
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
                                child: CustomNewsCard(
                                  img:
                                      "https://cdn1-production-images-kly.akamaized.net/lMHji7xE4GI7YHCWAQumKfFm9Ew=/1200x900/smart/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/3554482/original/037161700_1630219411-bandung-5319951_1920.jpg",
                                  title:
                                      "Prabowo Atau Anies, Siapa Capres yang Paling Kuat?",
                                  writer: "Udin Saparudin",
                                  date: "Jumat, 13 Mei 2022",
                                  onTap: () {
                                    // To detail News
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        curve: Curves.easeOut,
                                        type: PageTransitionType.bottomToTop,
                                        child: const NewsDetailScreen(),
                                        duration:
                                            const Duration(milliseconds: 150),
                                        reverseDuration:
                                            const Duration(milliseconds: 150),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                            childCount: 5,
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
