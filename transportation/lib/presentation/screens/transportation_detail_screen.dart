import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:transportation/data/datasources/transportation_remote_data_source.dart';
import 'package:transportation/data/models/station_detail.dart';
import 'package:transportation/presentation/components/custom_first_container_detail.dart';
import 'package:transportation/presentation/components/custom_secondary_container_detail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// Check

enum TransportationDetailScreenProcessEnum {
  loading,
  loaded,
  failed,
}

class TransportationDetailScreen extends StatefulWidget {
  // Add Parameter Data Train Detail
  final bool isTrain;
  final String? station;
  final String? idStation;
  const TransportationDetailScreen({
    Key? key,
    required this.isTrain,
    this.station,
    this.idStation,
  }) : super(key: key);

  @override
  State<TransportationDetailScreen> createState() =>
      _TransportationDetailScreenState();
}

class _TransportationDetailScreenState
    extends State<TransportationDetailScreen> {
  List<String> carouselImages = [
    'https://terkinni.com/wp-content/uploads/2022/06/red_velvet-20220322-001-non_fotografer_kly.jpg',
    'https://www.jd.id/news/wp-content/uploads/2022/03/Album-Blackpink-min.jpg',
    'https://img.celebrities.id/okz/900/yE79u7/master_w524V5OHB5_1654_twice.jpg',
  ];

  // State for loading
  TransportationDetailScreenProcessEnum process =
      TransportationDetailScreenProcessEnum.loaded;

  late Future<StationDetailResult> futureStation;

  @override
  void initState() {
    super.initState();
    print(widget.idStation!);
    if (widget.isTrain) {
      futureStation =
          TransportationRemoteDataSource().getStationDetail(widget.idStation!);
    }

    // // Must be repair
    // // Change with to fetch data
    // Timer(const Duration(seconds: 2), () {
    //   // Change state value if data loaded or failed
    //   setState(() {
    //     process = TransportationDetailScreenProcessEnum.loaded;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (process == TransportationDetailScreenProcessEnum.loading) {
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
    } else if (process == TransportationDetailScreenProcessEnum.failed) {
      return ErrorScreen(
        title: AppLocalizations.of(context)!.oops,
        message: AppLocalizations.of(context)!.screenSmall,
      );
    } else {
      return _buildScreen(context, screenSize);
    }
  }

  Widget _buildAppBar() {
    return CustomSliverAppBarTextLeading(
      // Text wait localization
      title: AppLocalizations.of(context)!.publicTransportationDetail,
      leadingIcon: "assets/icon/regular/chevron-left.svg",
      leadingOnTap: () {
        Navigator.pop(
          context,
        );
      },
    );
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
        body: _buildLoaded(context, screenSize, widget.isTrain),
      );
    }
  }

  Widget _buildLoaded(BuildContext context, Size screenSize, bool isTrain) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        _buildAppBar(),
        SliverPadding(
          padding: const EdgeInsets.all(20.0),
          sliver: SliverToBoxAdapter(
            child: FutureBuilder<StationDetailResult>(
              future: futureStation,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<String> image = [];
                  final List<String> review = [];
                  for (final photoid in snapshot.data!.result.photos) {
                    image.insert(0,
                        "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${photoid.photoReference}&key=AIzaSyAO1b9CLWFz6Y9NG14g2gpYP7TQWPRsPG0");
                  }
                  for (final reviews in snapshot.data!.result.reviews) {
                    review.insert(0, reviews.text);
                  }
                  return CustomFirstContainerDetail(
                    title: snapshot.data!.result.name,
                    address: snapshot.data!.result.vicinity,
                    onTap: () {},
                    carouselImages: image,
                    reviews: review,
                    rating: snapshot.data!.result.rating.toString(),
                    telephone: "(022) 4208757",
                    width: screenSize.width - 40.0,
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(20.0),
          sliver: SliverToBoxAdapter(
            child: CustomSecondaryContainerDetail(
              station: widget.station!,
              isTrain: widget.isTrain,
              title: (isTrain)
                  ? AppLocalizations.of(context)!.trainSchedule
                  : AppLocalizations.of(context)!.busSchedule,
              width: screenSize.width - 40.0,
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(20.0),
          sliver: SliverToBoxAdapter(
            child: CustomPrimaryIconTextButton(
              width: screenSize.width,
              text: AppLocalizations.of(context)!.directions,
              icon: "assets/icon/fill/map-marker.svg",
              onTap: () {},
            ),
          ),
        ),
      ],
    );
  }
}
