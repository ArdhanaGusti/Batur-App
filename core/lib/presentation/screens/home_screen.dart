import 'dart:async';

import 'package:core/presentation/bloc/dashboard_bloc.dart';
import 'package:core/presentation/components/appbar/custom_sliver_appbar_dashboard.dart';
import 'package:core/presentation/components/card/custom_news_card.dart';
import 'package:core/presentation/components/card/custom_tour_card.dart';
import 'package:core/presentation/components/card/custom_transport_card.dart';
import 'package:core/presentation/components/card/custom_umkm_card.dart';
import 'package:core/presentation/screens/error_screen.dart';
import 'package:news/news.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:theme/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:transportation/transportation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tourism/tourism.dart';
import 'package:umkm/presentation/screen/umkm_screen.dart';

enum HomeScreenProcessEnum {
  loading,
  loaded,
  failed,
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _controller;
  // Must be repair
  HomeScreenProcessEnum process = HomeScreenProcessEnum.loading;

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
      // Change state value if data loaded or failed
      setState(() {
        process = HomeScreenProcessEnum.loaded;
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
    if (process == HomeScreenProcessEnum.loading) {
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
    } else if (process == HomeScreenProcessEnum.failed) {
      return ErrorScreen(
        title: AppLocalizations.of(context)!.oops,
        message: AppLocalizations.of(context)!.screenSmall,
      );
    } else {
      return _buildLoaded(context);
    }
  }

  Widget _buildAppBar() {
    Brightness screenBrightness = MediaQuery.platformBrightnessOf(context);
    return CustomSliverAppBarDashboard(
      actionIcon: "assets/icon/regular/bell.svg",
      actionOnTap: () {
        // Navigate to Notification Page
        print("Go to Notification Page");
      },
      leading: BlocBuilder<ThemeManagerBloc, ThemeManagerState>(
        builder: (context, theme) {
          bool isLight = (theme.isDark == ThemeModeEnum.darkTheme)
              ? false
              : (theme.isDark == ThemeModeEnum.lightTheme)
                  ? true
                  : (screenBrightness == Brightness.light)
                      ? true
                      : false;
          return Image.asset(
            (isLight) ? "assets/logo/logo.png" : "assets/logo/logo_dark.png",
            height: 30.0,
          );
        },
      ),
      actionIconSecondary: "",
      actionOnTapSecondary: () {},
      isDoubleAction: false,
    );
  }

  Widget _buildLoaded(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 300.0 || screenSize.height < 600.0) {
      return ErrorScreen(
        // Text wait localization
        title: AppLocalizations.of(context)!.oops,
        message: AppLocalizations.of(context)!.screenSmall,
      );
    } else if (screenSize.width > 500.0) {
      // Tablet Mode (Must be repair)
      return Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500.0),
          child: _buildHomeScreen(context, screenSize),
        ),
      );
    } else {
      // Mobile Mode
      return _buildHomeScreen(context, screenSize);
    }
  }

  // Can it be save in Firebase ?
  final List<String> imgCarouselList = [
    "assets/image/hero-tour.png",
    "assets/image/hero-craft.png",
    "assets/image/hero-news.png",
    "assets/image/hero-transport.png",
  ];

  // Must be repair and Can it be save in Firebase ?
  final List<Widget> onTapCarouselList = [
    // Navigate to Tour List
    Builder(builder: (context) {
      return ErrorScreen(
        title: AppLocalizations.of(context)!.tour,
        message: AppLocalizations.of(context)!.tourList,
      );
    }),
    // Navigate to UMKM List
    Builder(builder: (context) {
      return ErrorScreen(
        title: AppLocalizations.of(context)!.umkm,
        message: AppLocalizations.of(context)!.umkmList,
      );
    }),
    // Navigate to News List
    // Not Working
    const NewsScreen(),
    // Navigate to Transport List
    Builder(builder: (context) {
      return ErrorScreen(
        title: AppLocalizations.of(context)!.transport,
        message: AppLocalizations.of(context)!.listTransport,
      );
    }),
  ];

  void onTapTourList() {
    // Navigate to Tour List
    // Navigator.push(context,
    //     MaterialPageRoute(builder: (context) => const TourListScreen()));
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const TourListScreen()));
  }

  void onTapNewsList() {
    // Navigate to News List
    context.read<DashboardBloc>().add(
          const IndexBottomNavChange(newIndex: 1),
        );
  }

  void onTapUMKMList() {
    // Navigate to UMKM List
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const UmkmScreen()));
  }

  void onTapTransportList() {
    // Navigate to Transport List
    Navigator.push(
      context,
      PageTransition(
        curve: Curves.easeInOut,
        type: PageTransitionType.bottomToTop,
        child: const TransportasiScreen(),
        duration: const Duration(milliseconds: 150),
        reverseDuration: const Duration(milliseconds: 150),
      ),
    );
  }

  Widget _buildCarousel(Size screenSize) {
    return CarouselSlider(
      options: CarouselOptions(
        viewportFraction: 0.92,
        aspectRatio: 2.25,
        enableInfiniteScroll: false,
        autoPlay: true,
      ),
      items: imgCarouselList.map(
        (image) {
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  if (imgCarouselList.indexOf(image) == 2) {
                    onTapNewsList();
                  } else {
                    Navigator.push(
                      context,
                      PageTransition(
                        curve: Curves.easeInOut,
                        type: PageTransitionType.bottomToTop,
                        child:
                            onTapCarouselList[imgCarouselList.indexOf(image)],
                        duration: const Duration(milliseconds: 150),
                        reverseDuration: const Duration(milliseconds: 150),
                      ),
                    );
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(
                    image,
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
          );
        },
      ).toList(),
    );
  }

  Widget _buildIconMenuColumn(
    bool isLight,
    String icon,
    String iconDark,
    String title,
    Function() onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Image.asset(
            (isLight) ? icon : iconDark,
            width: 70.0,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: Text(
              title,
              style: bBody1.copyWith(color: bGrey),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  SliverPadding _buildTitle(
    double leftPadding,
    double rightPadding,
    double topPadding,
    double botomPadding,
    String title,
    Function() onTap,
  ) {
    return SliverPadding(
      padding: EdgeInsets.only(
        left: leftPadding,
        right: rightPadding,
        top: topPadding,
        bottom: botomPadding,
      ),
      sliver: SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: bHeading7.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
            GestureDetector(
              onTap: onTap,
              child: Text(
                // Wait Localization
                AppLocalizations.of(context)!.showAll,
                style: bBody1.copyWith(color: bGrey),
              ),
            ),
          ],
        ),
      ),
    );
  }

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

  Widget _buildHomeScreen(BuildContext context, Size screenSize) {
    Brightness screenBrightness = MediaQuery.platformBrightnessOf(context);
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
              padding: const EdgeInsets.only(top: 20.0),
              sliver: SliverToBoxAdapter(
                child: _buildCarousel(screenSize),
              ),
            ),
            BlocBuilder<ThemeManagerBloc, ThemeManagerState>(
              builder: (context, theme) {
                bool isLight = (theme.isDark == ThemeModeEnum.darkTheme)
                    ? false
                    : (theme.isDark == ThemeModeEnum.lightTheme)
                        ? true
                        : (screenBrightness == Brightness.light)
                            ? true
                            : false;
                return SliverPadding(
                  padding: const EdgeInsets.only(
                    top: 30.0,
                    left: 20.0,
                    right: 20.0,
                  ),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisExtent: 135.0,
                      crossAxisSpacing: 10.0,
                    ),
                    delegate: SliverChildListDelegate(
                      [
                        _buildIconMenuColumn(
                          isLight,
                          "assets/icon/menu/icon-tour.png",
                          "assets/icon/menu/icon-tour-dark.png",
                          // Wait Localization
                          AppLocalizations.of(context)!.tour,
                          onTapTourList,
                        ),
                        _buildIconMenuColumn(
                          isLight,
                          "assets/icon/menu/icon-news.png",
                          "assets/icon/menu/icon-news-dark.png",
                          // Wait Localization
                          AppLocalizations.of(context)!.news,
                          onTapNewsList,
                        ),
                        _buildIconMenuColumn(
                          isLight,
                          "assets/icon/menu/icon-umkm.png",
                          "assets/icon/menu/icon-umkm-dark.png",
                          // Wait Localization
                          AppLocalizations.of(context)!.umkm,
                          onTapUMKMList,
                        ),
                        _buildIconMenuColumn(
                          isLight,
                          "assets/icon/menu/icon-bus.png",
                          "assets/icon/menu/icon-bus-dark.png",
                          // Wait Localization
                          AppLocalizations.of(context)!.publicTransportation,
                          onTapTransportList,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            _buildTitle(
              20.0,
              20.0,
              0,
              0,
              // Wait Localization
              AppLocalizations.of(context)!.news,
              onTapNewsList,
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    // Use Data News
                    return Padding(
                      padding: const EdgeInsets.only(top: 15.0),
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
                  childCount: 4,
                ),
              ),
            ),
            _buildTitle(
              20.0,
              20.0,
              30.0,
              0,
              // Wait Localization
              AppLocalizations.of(context)!.tour,
              onTapTourList,
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 260.0,
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  slivers: <Widget>[
                    SliverPadding(
                      padding: const EdgeInsets.only(left: 20.0),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            // Use data Tour
                            return Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: CustomTourCard(
                                img:
                                    "https://akcdn.detik.net.id/visual/2020/03/12/2049bba1-49a2-4efb-a253-82825d9c1f2d_169.jpeg?w=650",
                                // Process Rating must be 2 digit
                                rating: "4.5",
                                title: "Gedung Sate satu dua tiga",
                                isFavourited: true,
                                description:
                                    "Lorem ipsum It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                                onTap: () {
                                  // To detail Tour
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
            ),
            _buildTitle(
              20.0,
              20.0,
              10.0,
              0,
              // Wait Localization
              AppLocalizations.of(context)!.umkm,
              onTapUMKMList,
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 260.0,
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  slivers: <Widget>[
                    SliverPadding(
                      padding: const EdgeInsets.only(left: 20.0),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            // Use Data for UMKM
                            return Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: CustomUMKMCard(
                                img:
                                    "https://cdn-2.tstatic.net/tribunnews/foto/bank/images/indonesiatravel-gedung-sate-salah-satu-ikon-kota-bandung.jpg",
                                title: "Gedung Sate satu dua tiga",
                                isFavourited: false,
                                description:
                                    "Lorem ipsum It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                                onTap: () {
                                  // To detail UMKM
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
            ),
            _buildTitle(
              20.0,
              20.0,
              10.0,
              0,
              // Wait Localization
              AppLocalizations.of(context)!.publicTransportation,
              onTapTransportList,
            ),
            SliverPadding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
              sliver: SliverToBoxAdapter(
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
                            AppLocalizations.of(context)!.train,
                            style: bSubtitle3,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            // Wait Localization
                            AppLocalizations.of(context)!.bus,
                            style: bSubtitle3,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              // Still find solution if we delete the Sized Box
              child: SizedBox(
                height: 420.0,
                child: TabBarView(
                  physics: const BouncingScrollPhysics(),
                  controller: _controller,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          // Use Data for Train
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: CustomTransportCard(
                              img:
                                  "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                              title: "Trans Metro Bandung",
                              // Process the string of route
                              route: "Cibiru – Cibeureum",
                              time: "07.00 WIB -16.00 WIB",
                              onTap: () {
                                // To detail Train
                              },
                            ),
                          );
                        },
                        itemCount: 4,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          // Use Data for Bus
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: CustomTransportCard(
                              img:
                                  "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                              title: "Trans Metro Bandung",
                              // Process the string of route
                              route:
                                  "Cibiru – Cibeureumaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                              time: "07.00 WIB -16.00 WIB",
                              onTap: () {
                                // To detail Bus
                              },
                            ),
                          );
                        },
                        itemCount: 4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
