import 'dart:async';

import 'package:account/account.dart';
import 'package:core/presentation/bloc/dashboard_bloc.dart';
import 'package:core/presentation/components/appbar/custom_sliver_appbar_dashboard.dart';
import 'package:core/presentation/components/card/custom_news_card.dart';
import 'package:core/presentation/components/custom_smart_refresh.dart';
import 'package:core/presentation/screens/error_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// Check

enum NewsScreenProcessEnum {
  loading,
  loaded,
  failed,
}

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  NewsScreenProcessEnum process = NewsScreenProcessEnum.loading;

  // Refresh
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  // Refresh
  void _onRefresh() async {
    setState(() {
      process = NewsScreenProcessEnum.loading;
    });
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
    setState(() {
      process = NewsScreenProcessEnum.loaded;
    });
  }

  // Refresh
  void _onLoading() async {
    setState(() {
      process = NewsScreenProcessEnum.loading;
    });
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.loadComplete();
    setState(() {
      process = NewsScreenProcessEnum.loaded;
    });
  }

  @override
  void initState() {
    super.initState();
    if (user != null) {
      context.read<DashboardBloc>().add(OnIsAdmin(email: user!.email!));
    }

    if (mounted) {
      setState(() {
        process = NewsScreenProcessEnum.loaded;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (process == NewsScreenProcessEnum.loading) {
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
    } else if (process == NewsScreenProcessEnum.failed) {
      return const ErrorScreen(
        // Text wait localization
        title: "Opps...",
        message: "Tidak ada internet, Coba lagi nanti.",
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
        title: "Aduh...",
        message: "Layar terlalu kecil, coba di perangkat lain.",
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
          leading: const Text(
            // Text wait localization
            "Berita",
            textAlign: TextAlign.center,
          ),
          actionIconSecondary: "assets/icon/regular/plus-square.svg",
          actionOnTapSecondary: () {
            // Navigate to Add News
          },
          isDoubleAction: state.isAdmin,
        );
      },
    );
  }

  Widget _buildNewsScreen(BuildContext context, Size screenSize) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          _buildAppBar(),
        ];
      },
      body: CustomSmartRefresh(
        refreshController: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
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
    );
  }
}
