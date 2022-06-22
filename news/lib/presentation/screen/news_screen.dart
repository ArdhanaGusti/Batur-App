import 'dart:async';

import 'package:capstone_design/presentation/components/appbar/custom_sliver_appbar_dashboard.dart';
import 'add_news_screen.dart';
import 'package:capstone_design/presentation/screens/error_screen.dart';
import 'news_detail_screen.dart';
import '../components/card/custom_news_card.dart';
import 'package:capstone_design/presentation/screens/notifikasi/notifikasi_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:theme/theme.dart';
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

class _NewsScreenState extends State<NewsScreen> {
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
      return ErrorScreen(
        // Text wait localization
        title: AppLocalizations.of(context)!.internetConnection,
        message: AppLocalizations.of(context)!.tryAgain,
      );
    } else {
      return _buildLoaded(context);
    }
  }

  Widget _buildLoaded(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 300.0 || screenSize.height < 600.0) {
      return ErrorScreen(
        // Text wait localization
        title: AppLocalizations.of(context)!.screenError,
        message: AppLocalizations.of(context)!.screenSmall,
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
          refreshingText: AppLocalizations.of(context)!.refreshingText,
          releaseText: AppLocalizations.of(context)!.releaseText,
          idleText: AppLocalizations.of(context)!.idleText,
          failedText: AppLocalizations.of(context)!.failedText,
          completeText: AppLocalizations.of(context)!.completeText,
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
                              duration: const Duration(milliseconds: 150),
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
    );
  }
}
