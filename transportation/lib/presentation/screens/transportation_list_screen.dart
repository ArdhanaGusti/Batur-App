import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:theme/theme.dart';
import 'package:transportation/data/datasources/transportation_remote_data_source.dart';
import 'package:transportation/data/model/station.dart';
import 'package:transportation/presentation/components/custom_card_transportation_list.dart';
import 'package:transportation/presentation/screens/transportation_detail_screen.dart';

// Check

enum TransportationListScreenProcessEnum {
  loading,
  loaded,
  failed,
}

class TransportationListScreen extends StatefulWidget {
  const TransportationListScreen({Key? key}) : super(key: key);

  @override
  State<TransportationListScreen> createState() =>
      _TransportationListScreenState();
}

class _TransportationListScreenState extends State<TransportationListScreen> {
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
  final RefreshController _refreshControllerTrain =
      RefreshController(initialRefresh: false);

  void _onRefreshTrain() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshControllerTrain.refreshCompleted();
  }

  void _onLoadingTrain() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshControllerTrain.loadComplete();
  }

  final RefreshController _refreshControllerBus =
      RefreshController(initialRefresh: false);

  void _onRefreshBus() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshControllerBus.refreshCompleted();
  }

  void _onLoadingBus() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshControllerBus.loadComplete();
  }

  // State for loading
  TransportationListScreenProcessEnum process =
      TransportationListScreenProcessEnum.loaded;

  // @override
  // void initState() {
  //   super.initState();

  //   // Change with to fetch data
  //   Timer(const Duration(seconds: 3), () {
  //     // Change state value if data loaded or failed
  //     setState(() {
  //       process = TransportationListScreenProcessEnum.loaded;
  //     });
  //   });
  // }

  late Future<StationResult> futureStation;

  @override
  void initState() {
    super.initState();
    futureStation = TransportationRemoteDataSource().getStation();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (process == TransportationListScreenProcessEnum.loading) {
      return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            _buildAppBar(),
          ];
        },
        body: Scaffold(
          body: Center(
            child: LoadingAnimationWidget.horizontalRotatingDots(
              color: Theme.of(context).colorScheme.tertiary,
              size: 50.0,
            ),
          ),
        ),
      );
    } else if (process == TransportationListScreenProcessEnum.failed) {
      return const ErrorScreen(
        title: "AppLocalizations.of(context)!.oops",
        message: "AppLocalizations.of(context)!.screenSmall",
      );
    } else {
      return _buildScreen(context, screenSize);
    }
  }

  Widget _buildScreen(BuildContext context, Size screenSize) {
    if (screenSize.width < 300.0 || screenSize.height < 600.0) {
      return const ErrorScreen(
        // Text wait localization
        title: "Eror",
        message: "Eror",
      );
    } else {
      // Mobile Mode
      return Scaffold(
        body: _buildLoaded(context, screenSize),
      );
    }
  }

  Widget _buildAppBar() {
    return CustomSliverAppBarTextLeadingAction(
      // Text wait localization
      title: "Transportasi Umum",
      leadingIcon: "assets/icon/regular/chevron-left.svg",
      leadingOnTap: () {
        Navigator.pop(
          context,
        );
      },
      actionIcon: "assets/icon/regular/map.svg",
      actionOnTap: () {
        Navigator.pop(
          context,
        );
      },
    );
  }

  Widget _buildLoaded(BuildContext context, Size screenSize) {
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
                          "Kereta",
                          style: bSubtitle3,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          // Wait Localization
                          "Bus",
                          style: bSubtitle3,
                        ),
                      ),
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
                  refreshController: _refreshControllerTrain,
                  onLoading: _onLoadingTrain,
                  onRefresh: _onRefreshTrain,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: FutureBuilder<StationResult>(
                      future: futureStation,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final place = snapshot.data!.results;
                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              if (title.contains(place[index].name)) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: (place[index].photos == null)
                                      ? CustomCardStasiunList(
                                          image:
                                              'http://via.placeholder.com/350x150',
                                          title: place[index].name,
                                          address: place[index].vicinity,
                                          rating:
                                              place[index].rating.toString(),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              PageTransition(
                                                curve: Curves.easeInOut,
                                                type: PageTransitionType
                                                    .bottomToTop,
                                                // Add Parameter Data Train Detail
                                                child:
                                                    const TransportationDetailScreen(
                                                  isTrain: true,
                                                  station: "Kiaracondong",
                                                ),
                                                duration: const Duration(
                                                    milliseconds: 150),
                                                reverseDuration: const Duration(
                                                    milliseconds: 150),
                                              ),
                                            );
                                          },
                                        )
                                      : CustomCardStasiunList(
                                          image:
                                              "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${place[index].photos![0].photoReference}&key=AIzaSyAO1b9CLWFz6Y9NG14g2gpYP7TQWPRsPG0",
                                          title: place[index].name,
                                          address: place[index].vicinity,
                                          rating:
                                              place[index].rating.toString(),
                                          onTap: () {
                                            final indexTitleStation = title
                                                .indexOf(place[index].name);
                                            final titleStation = titleFirebase[
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
                                                ),
                                                duration: const Duration(
                                                    milliseconds: 150),
                                                reverseDuration: const Duration(
                                                    milliseconds: 150),
                                              ),
                                            );
                                          },
                                        ),
                                );
                              } else {
                                return Container();
                              }
                              // Use Data Train
                            },
                            itemCount: place.length,
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
                CustomSmartRefresh(
                  refreshController: _refreshControllerBus,
                  onLoading: _onLoadingBus,
                  onRefresh: _onRefreshBus,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        // Use Data Bus
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: CustomCardStasiunList(
                            image:
                                "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                            title: "Terninal Bandung Kota",
                            address:
                                "Jl. Stasiun Barat, Kb. Jeruk, Kec. Andir, Bandung",
                            rating: '5.0',
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  curve: Curves.easeInOut,
                                  type: PageTransitionType.bottomToTop,
                                  child: const TransportationDetailScreen(
                                    isTrain: false,
                                    station: "Jalan Soekarno Hatta 517",
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
                      itemCount: 10,
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
