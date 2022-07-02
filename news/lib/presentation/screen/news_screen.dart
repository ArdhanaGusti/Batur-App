import 'dart:async';

import 'package:account/account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:core/presentation/components/appbar/custom_sliver_appbar_dashboard.dart';
import 'package:core/presentation/components/card/custom_news_card.dart';
import 'package:core/presentation/components/custom_smart_refresh.dart';
import 'package:core/presentation/screens/error_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news/data/model/news.dart';
import 'package:news/presentation/screen/news_detail_screen_api.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:theme/theme.dart';

import '../../data/datasources/news_remote_data_source.dart';
import 'add_news_screen.dart';
import 'news_detail_screen.dart';

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
  User? user = FirebaseAuth.instance.currentUser;
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

  late Future<ArticlesResult> futureArticle;

  @override
  void initState() {
    super.initState();

    futureArticle = NewsRemoteDataSource().bandungNewsId();

    if (user != null) {
      context.read<DashboardBloc>().add(OnIsAdmin(email: user!.email!));
    }

    _controller = TabController(
      vsync: this,
      length: 2,
    );

    if (mounted) {
      setState(() {
        process = ScreenProcessEnum.loaded;
      });
    }
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
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return CustomSliverAppBarDashboard(
          actionIcon: "assets/icon/regular/bell.svg",
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
              ),
            );
          },
          isDoubleAction: state.isAdmin,
        );
      },
    );
  }

  Widget _buildNewsScreen(BuildContext context, Size screenSize) {
    return DefaultTabController(
      length: 2, // Length of tabs
      initialIndex: 0,
      child: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: <Widget>[
          _buildAppBar(),
          SliverToBoxAdapter(
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
          ),
          SliverFillRemaining(
            child: TabBarView(
              physics: const BouncingScrollPhysics(),
              children: <Widget>[
                CustomSmartRefresh(
                  onLoading: _onLoading,
                  onRefresh: _onRefresh,
                  refreshController: _refreshController,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("News")
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
                        return Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              // Use Data News
                              return Padding(
                                padding: const EdgeInsets.only(
                                    right: 20, left: 20, bottom: 15),
                                child: CustomNewsCard(
                                  img:
                                      '${snapshot.data!.docs[index]['coverUrl']}',
                                  title: snapshot.data!.docs[index]['title'],
                                  author: snapshot.data!.docs[index]
                                      ['username'],
                                  date: DateFormat("EEEE, d MMMM yyyy", "id_ID")
                                      .format(DateTime.parse(
                                          snapshot.data!.docs[index]['date'])),
                                  onTap: () {
                                    // To detail News
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        curve: Curves.easeOut,
                                        type: PageTransitionType.bottomToTop,
                                        child: NewsDetailScreen(
                                          title: snapshot.data!.docs[index]
                                              ['title'],
                                          konten: snapshot.data!.docs[index]
                                              ['content'],
                                          index: snapshot
                                              .data!.docs[index].reference,
                                          urlName: snapshot.data!.docs[index]
                                              ['coverUrl'],
                                          author: snapshot.data!.docs[index]
                                              ['username'],
                                          email: snapshot.data!.docs[index]
                                              ['email'],
                                          date: snapshot.data!.docs[index]
                                              ['date'],
                                        ),
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
                            itemCount: snapshot.data!.docs.length,
                          ),
                        );
                      }),
                ),
                CustomSmartRefresh(
                  refreshController: _refreshController2,
                  onLoading: _onLoading2,
                  onRefresh: _onRefresh2,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: FutureBuilder<ArticlesResult>(
                      future: futureArticle,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final news = snapshot.data!.articles;
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 15, right: 20, left: 20),
                                child: CustomNewsCard(
                                  img: news[index].urlToImage,
                                  title: news[index].title,
                                  author: news[index].author,
                                  date: DateFormat("EEEE, d MMMM yyyy", "id_ID")
                                      .format(DateTime.parse(snapshot
                                          .data!.articles[index].publishedAt
                                          .toString())),
                                  onTap: () {
                                    // To detail News
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        curve: Curves.easeOut,
                                        type: PageTransitionType.bottomToTop,
                                        child: NewsDetailScreenApi(
                                          img: news[index].urlToImage,
                                          title: news[index].title,
                                          author: news[index].author,
                                          date: DateFormat(
                                                  "EEEE, d MMMM yyyy", "id_ID")
                                              .format(DateTime.parse(snapshot
                                                  .data!
                                                  .articles[index]
                                                  .publishedAt
                                                  .toString())),
                                          url: news[index].url,
                                          content: news[index].content,
                                        ),
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
                            itemCount: news.length,
                          );
                        } else if (snapshot.hasError) {
                          return Container();
                        } else {
                          return Container();
                        }
                      },
                    ),
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
