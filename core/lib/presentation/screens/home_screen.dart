import 'dart:async';

import 'package:account/account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/presentation/bloc/dashboard_bloc.dart';
import 'package:core/presentation/components/appbar/custom_sliver_appbar_dashboard.dart';
import 'package:core/presentation/components/card/custom_news_card.dart';
import 'package:core/presentation/components/card/custom_tour_card.dart';
import 'package:core/presentation/components/card/custom_transport_card.dart';
import 'package:core/presentation/components/card/custom_umkm_card.dart';
import 'package:core/presentation/components/custom_smart_refresh.dart';
import 'package:core/presentation/screens/error_screen.dart';
import 'package:core/utils/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:news/data/datasources/news_remote_data_source.dart';
import 'package:news/data/model/news.dart';
import 'package:news/news.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news/presentation/screen/news_detail_screen_api.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:theme/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tourism/data/datasource/tourism_remote_data_source.dart';
import 'package:tourism/data/models/tourist_attraction.dart';
import 'package:tourism/data/service/api_service_tour.dart';
import 'package:transportation/data/datasources/transportation_remote_data_source.dart';
import 'package:transportation/data/models/station.dart';
import 'package:transportation/transportation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tourism/tourism.dart';
import 'package:umkm/umkm.dart';

// Check

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
  User? user = FirebaseAuth.instance.currentUser;
  late TabController _controller;
  HomeScreenProcessEnum process = HomeScreenProcessEnum.loading;
  final toast = FToast();
  final apiKey = Config().mapsKey;
  final photosUrl = Config().photosUrl;

  List<String> title = [
    "Cimahi",
    "Cicalengka",
    "Padalarang",
    "Haurpugur",
    "Rancaekek",
    "Cimekar",
    "Gedebage",
    "Cikudapateuh",
    "Ciroyom",
    "Stasiun Cimindi",
    "Stasiun Bandung",
    "Gadobangkong",
    "Kiaracondong"
  ];

  List<String> titleFirebase = [
    "Cimahi",
    "Cicalengka",
    "Padalarang",
    "Haurpugur",
    "Rancaekek",
    "Cimekar",
    "Gedebage",
    "Cikudapateuh",
    "Ciroyom",
    "Cimindi",
    "Bandung",
    "Kiaracondong"
  ];

  late Future<ArticlesResult> futureArticle;
  late Future<TouristAttractionResult> futurePlace;
  late Future<StationResult> futureStation;

  @override
  void initState() {
    toast.init(context);
    _controller = TabController(
      vsync: this,
      length: 2,
    );
    super.initState();
    futureStation = TransportationRemoteDataSource().getStation();

    futureArticle = NewsRemoteDataSource().bandungNewsId();
    futurePlace = TourismRemoteDataSource().getTouristAttraction();

    if (user != null) {
      context.read<DashboardBloc>().add(OnIsHaveProfile(email: user!.email!));
      context.read<DashboardBloc>().add(OnIsAdmin(email: user!.email!));
    }

    if (mounted) {
      setState(() {
        process = HomeScreenProcessEnum.loaded;
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
    if (process == HomeScreenProcessEnum.loading) {
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
                (isLight)
                    ? "assets/logo/logo.png"
                    : "assets/logo/logo_dark.png",
                height: 30.0,
              );
            },
          ),
          actionIconSecondary: "",
          actionOnTapSecondary: () {},
          isDoubleAction: false,
        );
      },
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

  final List<String> imgCarouselList = [
    "assets/image/hero-tour.png",
    "assets/image/hero-craft.png",
    "assets/image/hero-news.png",
    "assets/image/hero-transport.png",
  ];

  final List<Widget> onTapCarouselList = [
    const TourMapScreen(),
    const UmkmMapsScreen(),
    const NewsScreen(),
    const TransportationMapScreen(),
  ];

  void onTapTourList() {
    // Navigate to Tour List
    Navigator.push(
      context,
      PageTransition(
        curve: Curves.easeInOut,
        type: PageTransitionType.bottomToTop,
        child: const TourMapScreen(),
      ),
    );
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
        .push(MaterialPageRoute(builder: (context) => const UmkmMapsScreen()));
  }

  void onTapTransportList() {
    // Navigate to Transport List
    Navigator.push(
      context,
      PageTransition(
        curve: Curves.easeInOut,
        type: PageTransitionType.bottomToTop,
        child: const TransportationMapScreen(),
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

  Widget _buildHomeScreen(BuildContext context, Size screenSize) {
    Brightness screenBrightness = MediaQuery.platformBrightnessOf(context);
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
              sliver: SliverToBoxAdapter(
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
                            padding: const EdgeInsets.only(bottom: 15.0),
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
                                              .data!.articles[index].publishedAt
                                              .toString())),
                                      url: news[index].url,
                                      content: news[index].content,
                                    ),
                                    duration: const Duration(milliseconds: 150),
                                    reverseDuration:
                                        const Duration(milliseconds: 150),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        itemCount: 4,
                      );
                    } else if (snapshot.hasError) {
                      return Container();
                    } else {
                      return LoadingAnimationWidget.horizontalRotatingDots(
                        color: Theme.of(context).colorScheme.tertiary,
                        size: 50.0,
                      );
                    }
                  },
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
                              child: FutureBuilder<TouristAttractionResult>(
                                future: futurePlace,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    final place = snapshot.data!.results;
                                    return StreamBuilder<QuerySnapshot>(
                                        stream: (user != null)
                                            ? FirebaseFirestore.instance
                                                .collection("FavoriteTour")
                                                .where('email',
                                                    isEqualTo: user!.email)
                                                .where("tour",
                                                    isEqualTo:
                                                        place[index].name)
                                                .snapshots()
                                            : FirebaseFirestore.instance
                                                .collection("FavoriteTour")
                                                .where("tour",
                                                    isEqualTo:
                                                        place[index].name)
                                                .snapshots(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return Container();
                                          }
                                          return CustomTourCard(
                                            img:
                                                '$photosUrl${place[index].photos[0].photoReference}&key=$apiKey',
                                            // Process Rating must be 2 digit
                                            rating:
                                                place[index].rating.toString(),
                                            title: place[index].name,
                                            isFavourited: (user != null)
                                                ? (snapshot
                                                        .data!.docs.isNotEmpty)
                                                    ? true
                                                    : false
                                                : false,
                                            description:
                                                "Lorem ipsum It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                                            onTap: () {
                                              // To detail Tour
                                              Navigator.push(
                                                context,
                                                PageTransition(
                                                  curve: Curves.easeInOut,
                                                  type: PageTransitionType
                                                      .bottomToTop,
                                                  // Navigate to detail with parameter

                                                  child: TourDetailScreen(
                                                    id: place[index].placeId,
                                                  ),
                                                ),
                                              );
                                            },
                                            heartTap: () {
                                              if (user != null) {
                                                if (snapshot
                                                    .data!.docs.isEmpty) {
                                                  ApiServiceTour().addFavorite(
                                                      place[index].rating,
                                                      place[index].vicinity,
                                                      place[index].name,
                                                      '$photosUrl${place[index].photos[0].photoReference}&key=$apiKey');
                                                } else {
                                                  ApiServiceTour()
                                                      .removeFavorite(snapshot
                                                          .data!
                                                          .docs[0]
                                                          .reference);
                                                }
                                              } else {
                                                Navigator.push(
                                                  context,
                                                  PageTransition(
                                                    curve: Curves.easeInOut,
                                                    type: PageTransitionType
                                                        .bottomToTop,
                                                    child: const LoginScreen(),
                                                  ),
                                                );
                                              }
                                            },
                                          );
                                        });
                                  } else if (snapshot.hasError) {
                                    return Container();
                                  } else {
                                    return Container();
                                  }
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
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("UMKM")
                      .where("verification", isEqualTo: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text(
                          AppLocalizations.of(context)!.umkmNotFound,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: bHeading7.copyWith(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: LoadingAnimationWidget.horizontalRotatingDots(
                          color: Theme.of(context).colorScheme.tertiary,
                          size: 30.0,
                        ),
                      );
                    }
                    return SizedBox(
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
                                  final data = snapshot.data!.docs[index];
                                  // Use Data for UMKM
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: (user == null)
                                          ? FirebaseFirestore.instance
                                              .collection("Favorite")
                                              .where("umkm",
                                                  isEqualTo: data["name"])
                                              .snapshots()
                                          : FirebaseFirestore.instance
                                              .collection("Favorite")
                                              .where("umkm",
                                                  isEqualTo: data["name"])
                                              .where("email",
                                                  isEqualTo: user!.email)
                                              .where("seller",
                                                  isEqualTo: data["email"])
                                              .snapshots(),
                                      builder: (context, fav) {
                                        if (fav.data == null || user == null) {
                                          return CustomUMKMCard(
                                            img: data['coverUrl'],
                                            title: data['name'],
                                            isFavourited: false,
                                            description: data['desc'],
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                PageTransition(
                                                  curve: Curves.easeInOut,
                                                  type: PageTransitionType
                                                      .rightToLeft,
                                                  child: UmkmDetailScreen(
                                                    name: data['name'],
                                                    coverUrl: data['coverUrl'],
                                                    address: data['address'],
                                                    desc: data['desc'],
                                                    index: data.reference,
                                                    type: data['desc'],
                                                    noHp: data['phone'],
                                                    email: data["email"],
                                                    web: data["website"],
                                                    tokped: data["tokped"],
                                                    shopee: data["shopee"],
                                                  ),
                                                  duration: const Duration(
                                                      milliseconds: 150),
                                                  reverseDuration:
                                                      const Duration(
                                                          milliseconds: 150),
                                                ),
                                              );
                                            },
                                            onHeartTap: () {
                                              Navigator.push(
                                                context,
                                                PageTransition(
                                                  curve: Curves.easeInOut,
                                                  type: PageTransitionType
                                                      .bottomToTop,
                                                  child: const LoginScreen(),
                                                ),
                                              );
                                            },
                                          );
                                        }
                                        final favData = fav.data!.docs;
                                        return CustomUMKMCard(
                                          img: data['coverUrl'],
                                          title: data['name'],
                                          isFavourited:
                                              (favData.isEmpty) ? false : true,
                                          description: data['desc'],
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              PageTransition(
                                                curve: Curves.easeInOut,
                                                type: PageTransitionType
                                                    .rightToLeft,
                                                child: UmkmDetailScreen(
                                                  name: data['name'],
                                                  coverUrl: data['coverUrl'],
                                                  address: data['address'],
                                                  desc: data['desc'],
                                                  index: data.reference,
                                                  type: data['desc'],
                                                  noHp: data['phone'],
                                                  email: data["email"],
                                                  web: data["website"],
                                                  tokped: data["tokped"],
                                                  shopee: data["shopee"],
                                                ),
                                                duration: const Duration(
                                                    milliseconds: 150),
                                                reverseDuration: const Duration(
                                                    milliseconds: 150),
                                              ),
                                            );
                                          },
                                          onHeartTap: () {
                                            if (favData.isEmpty) {
                                              ApiServiceUMKM().addFavorite(
                                                  data['coverUrl'],
                                                  data['address'],
                                                  data['email'],
                                                  "",
                                                  data['name']);
                                            } else {
                                              ApiServiceUMKM().removeFavorite(
                                                  favData[0].reference);
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  );
                                },
                                childCount: snapshot.data!.docs.length,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
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
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 20.0,
              ),
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
              child: SizedBox(
                height: 420.0,
                child: TabBarView(
                  physics: const BouncingScrollPhysics(),
                  controller: _controller,
                  children: <Widget>[
                    FutureBuilder<StationResult>(
                      future: futureStation,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                print(snapshot.data!.results[index].name);
                                if (title.contains(
                                    snapshot.data!.results[index].name)) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 15.0),
                                    child: (snapshot
                                                .data!.results[index].photos ==
                                            null)
                                        ? CustomTransportCard(
                                            img:
                                                'http://via.placeholder.com/350x150',
                                            title: snapshot
                                                .data!.results[index].name,
                                            // Process the string of route
                                            route: snapshot
                                                .data!.results[index].vicinity,
                                            time: "Buka",
                                            onTap: () {
                                              // To detail Train
                                              final indexTitleStation =
                                                  title.indexOf(snapshot.data!
                                                      .results[index].name);
                                              final titleStation =
                                                  titleFirebase[
                                                      indexTitleStation];
                                              Navigator.push(
                                                context,
                                                PageTransition(
                                                  curve: Curves.easeInOut,
                                                  type: PageTransitionType
                                                      .bottomToTop,
                                                  // Add Parameter Data Train Detail
                                                  child:
                                                      TransportationDetailScreen(
                                                    isTrain: true,
                                                    station: titleStation,
                                                    idStation: snapshot.data!
                                                        .results[index].placeId,
                                                  ),
                                                  duration: const Duration(
                                                      milliseconds: 150),
                                                  reverseDuration:
                                                      const Duration(
                                                          milliseconds: 150),
                                                ),
                                              );
                                            },
                                          )
                                        : CustomTransportCard(
                                            img:
                                                "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${snapshot.data!.results[index].photos![0].photoReference}&key=AIzaSyAO1b9CLWFz6Y9NG14g2gpYP7TQWPRsPG0",
                                            title: snapshot
                                                .data!.results[index].name,
                                            // Process the string of route
                                            route: snapshot
                                                .data!.results[index].vicinity,
                                            time: "Buka",
                                            onTap: () {
                                              // To detail Train
                                              final indexTitleStation =
                                                  title.indexOf(snapshot.data!
                                                      .results[index].name);
                                              final titleStation =
                                                  titleFirebase[
                                                      indexTitleStation];
                                              Navigator.push(
                                                context,
                                                PageTransition(
                                                  curve: Curves.easeInOut,
                                                  type: PageTransitionType
                                                      .bottomToTop,
                                                  // Add Parameter Data Train Detail
                                                  child:
                                                      TransportationDetailScreen(
                                                    isTrain: true,
                                                    station: titleStation,
                                                    idStation: snapshot.data!
                                                        .results[index].placeId,
                                                  ),
                                                  duration: const Duration(
                                                      milliseconds: 150),
                                                  reverseDuration:
                                                      const Duration(
                                                          milliseconds: 150),
                                                ),
                                              );
                                            },
                                          ),
                                  );
                                } else {
                                  return Container();
                                }
                                // Use Data for Train
                              },
                              itemCount: 7,
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("Bus")
                            .snapshots(),
                        builder: (context, snapshot) {
                          final List<String> route = [];
                          final List<String> tmb = [];
                          if (snapshot.hasData) {
                            for (final indexxx in snapshot.data!.docs) {
                              if (route.contains(indexxx["route"])) {
                              } else {
                                // buusss.insert(0, indexxx["transit"]);
                                route.insert(0, indexxx["route"]);
                                tmb.insert(0, indexxx["name"]);
                              }
                            }
                          } else {
                            return Container();
                          }
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                // Use Data for Bus
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: CustomTransportCard(
                                    img:
                                        "https://upload.wikimedia.org/wikipedia/commons/2/24/Logo_TMB_Trans_Metro_Bandung.jpg",
                                    title: tmb[index],
                                    // Process the string of route
                                    route: route[index],
                                    time: "Buka",
                                    onTap: () {
                                      // To detail Bus
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          curve: Curves.easeInOut,
                                          type: PageTransitionType.bottomToTop,
                                          child: TimeLineScreen(
                                              name: tmb[index], isTrain: false),
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
                              itemCount: 4,
                            ),
                          );
                        }),
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
