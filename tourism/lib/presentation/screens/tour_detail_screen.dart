import 'package:core/core.dart';
import 'package:core/utils/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:theme/theme.dart';
import 'package:tourism/presentation/components/custom_card_detail_tour_screen.dart';

import '../../data/datasource/tourism_remote_data_source.dart';
import '../../data/models/tourist_attraction_detail.dart';

enum TourDetailScreenProcessEnum {
  loading,
  loaded,
  failed,
}

class TourDetailScreen extends StatefulWidget {
  final String id;

  const TourDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<TourDetailScreen> createState() => _TourDetailScreenState();
}

class _TourDetailScreenState extends State<TourDetailScreen> {
  TourDetailScreenProcessEnum process = TourDetailScreenProcessEnum.loading;

  final apiKey = Config().mapsKey;
  final photosUrl = Config().photosUrl;

  final List<String> carouselImages = [
    "https://thumb.viva.co.id/media/frontend/thumbs3/2022/03/23/623b099186419-red-velvet_665_374.jpg",
    "https://awsimages.detik.net.id/visual/2020/09/15/noah-15.jpeg?w=650",
    "https://media.suara.com/pictures/653x366/2022/02/09/60554-isyana-sarasvati-instagramatisyanasarasvati.jpg",
  ];

  late Future<TouristAttractionDetailResult> futurePlace;

  @override
  void initState() {
    super.initState();
    futurePlace =
        TourismRemoteDataSource().getTouristAttractionDetail(widget.id);

    if (mounted) {
      setState(() {
        process = TourDetailScreenProcessEnum.loaded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    if (process == TourDetailScreenProcessEnum.loading) {
      return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
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
    } else if (process == TourDetailScreenProcessEnum.failed) {
      return ErrorScreen(
        title: AppLocalizations.of(context)!.oops,
        message: AppLocalizations.of(context)!.screenSmall,
      );
    } else {
      return _buildSuccess(screenSize);
    }
  }

  Widget _buildSuccess(Size screenSize) {
    if (screenSize.width < 300.0 || screenSize.height < 600.0) {
      return const ErrorScreen(
        // Text wait localization
        title: "Eror",
        message: "Eror",
      );
    } else if (screenSize.width > 500.0) {
      // Mobile Mode
      return Scaffold(
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500.0),
            child: _buildLoaded(screenSize),
          ),
        ),
      );
    } else {
      // Mobile Mode
      return Scaffold(
        body: _buildLoaded(screenSize),
      );
    }
  }

  Widget _buildAppBar() {
    return CustomSliverAppBarTextLeading(
      // Text wait localization
      title: AppLocalizations.of(context)!.tourDetail,
      leadingIcon: "assets/icon/regular/chevron-left.svg",
      leadingOnTap: () {
        Navigator.pop(
          context,
        );
      },
    );
  }

  Widget _buildLoaded(Size screenSize) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        _buildAppBar(),
        SliverPadding(
          padding: const EdgeInsets.all(20.0),
          sliver: SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                FutureBuilder<TouristAttractionDetailResult>(
                  future: futurePlace,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final place = snapshot.data!.result;
                      List<String> photos = [];
                      for (final index in place.photos) {
                        photos.insert(
                            0, "$photosUrl${index.photoReference}&key=$apiKey");
                      }
                      var monday = place.openingHours.weekdayText[0];
                      int idx = monday.indexOf(":");

                      var tuesday = place.openingHours.weekdayText[1];
                      int idx2 = tuesday.indexOf(":");

                      var wednesday = place.openingHours.weekdayText[2];
                      int idx3 = wednesday.indexOf(":");

                      var thursday = place.openingHours.weekdayText[3];
                      int idx4 = thursday.indexOf(":");

                      var friday = place.openingHours.weekdayText[4];
                      int idx5 = friday.indexOf(":");

                      var saturday = place.openingHours.weekdayText[5];
                      int idx6 = saturday.indexOf(":");

                      var sunday = place.openingHours.weekdayText[6];
                      int idx7 = sunday.indexOf(":");

                      List parts = [
                        monday.substring(idx + 1).trim(),
                        tuesday.substring(idx2 + 1).trim(),
                        wednesday.substring(idx3 + 1).trim(),
                        thursday.substring(idx4 + 1).trim(),
                        friday.substring(idx5 + 1).trim(),
                        saturday.substring(idx6 + 1).trim(),
                        sunday.substring(idx7 + 1).trim(),
                      ];

                      return Column(
                        children: [
                          CustomCardDetailTourScreen(
                            img: "",
                            title: place.name,

                            rating: place.rating.toString(),
                            carouselImages: photos,
                            review: place.reviews[0].text,
                            address: place.vicinity,
                            // telephone: place.formattedPhoneNumber,
                            onTap: () {
                              print("Container clicked");
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: screenSize.width,
                            padding: const EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              boxShadow: const [
                                BoxShadow(
                                  color: bStroke,
                                  spreadRadius: 2.0,
                                  blurRadius: 10.0,
                                  offset: Offset(
                                      0, 0), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  AppLocalizations.of(context)!.schedule,
                                  style: bHeading7.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      AppLocalizations.of(context)!.monday,
                                      style: bSubtitle3.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                      ),
                                    ),
                                    Text(
                                      parts[0],
                                      style: bSubtitle3,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      AppLocalizations.of(context)!.tuesday,
                                      style: bSubtitle3.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                      ),
                                    ),
                                    Text(
                                      parts[1],
                                      style: bSubtitle3,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      AppLocalizations.of(context)!.wednesday,
                                      style: bSubtitle3.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                      ),
                                    ),
                                    Text(
                                      parts[2],
                                      style: bSubtitle3,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      AppLocalizations.of(context)!.thursday,
                                      style: bSubtitle3.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                      ),
                                    ),
                                    Text(
                                      parts[3],
                                      style: bSubtitle3,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      AppLocalizations.of(context)!.friday,
                                      style: bSubtitle3.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                      ),
                                    ),
                                    Text(
                                      parts[4],
                                      style: bSubtitle3,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      AppLocalizations.of(context)!.saturday,
                                      style: bSubtitle3.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                      ),
                                    ),
                                    Text(
                                      parts[5],
                                      style: bSubtitle3,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      AppLocalizations.of(context)!.sunday,
                                      style: bSubtitle3.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                      ),
                                    ),
                                    Text(
                                      parts[6],
                                      style: bSubtitle3,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          CustomPrimaryIconTextButton(
                            icon: "assets/icon/fill/map-marker.svg",
                            width: screenSize.width,
                            text: AppLocalizations.of(context)!.directions,
                            onTap: () {},
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Container();
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
