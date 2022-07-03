import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:theme/theme.dart';
import 'package:timelines/timelines.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Check

enum TimelineScreenProcessEnum {
  loading,
  loaded,
  failed,
}

class TimeLineScreen extends StatefulWidget {
  // Add Parameter Data Train
  final String name;
  final bool isTrain;
  const TimeLineScreen({
    Key? key,
    required this.isTrain,
    required this.name,
  }) : super(key: key);

  @override
  State<TimeLineScreen> createState() => _TimeLineScreenState();
}

class _TimeLineScreenState extends State<TimeLineScreen> {
  // State for loading
  TimelineScreenProcessEnum process = TimelineScreenProcessEnum.loaded;

  // @override
  // void initState() {
  //   super.initState();

  //   // Change with to fetch data
  //   Timer(const Duration(seconds: 2), () {
  //     // Change state value if data loaded or failed
  //     setState(() {
  //       process = TimelineScreenProcessEnum.loaded;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (process == TimelineScreenProcessEnum.loading) {
      return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            _buildAppBar(widget.name),
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
    } else if (process == TimelineScreenProcessEnum.failed) {
      return ErrorScreen(
        title: AppLocalizations.of(context)!.oops,
        message: AppLocalizations.of(context)!.screenSmall,
      );
    } else {
      return _buildScreen(context, screenSize, widget.name);
    }
  }

  Widget _buildAppBar(String trainName) {
    return CustomSliverAppBarTextLeading(
      // Change with data
      title: trainName,
      leadingIcon: "assets/icon/regular/chevron-left.svg",
      leadingOnTap: () {
        Navigator.pop(
          context,
        );
      },
    );
  }

  Widget _buildScreen(BuildContext context, Size screenSize, String trainName) {
    if (screenSize.width < 300.0 || screenSize.height < 600.0) {
      return ErrorScreen(
        // Text wait localization
        title: AppLocalizations.of(context)!.screenError,
        message: AppLocalizations.of(context)!.screenSmall,
      );
    } else {
      // Mobile Mode
      return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: (widget.isTrain)
                ? FirebaseFirestore.instance
                    .collection("Train")
                    .where("trainName", isEqualTo: widget.name)
                    .snapshots()
                : FirebaseFirestore.instance
                    .collection("Bus")
                    .where("name", isEqualTo: widget.name)
                    .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: LoadingAnimationWidget.horizontalRotatingDots(
                    color: Theme.of(context).colorScheme.tertiary,
                    size: 50.0,
                  ),
                );
              }
              final train = snapshot.data!.docs;

              return _buildLoaded(
                context,
                screenSize,
                trainName,
                train,
                widget.isTrain,
              );
            }),
      );
    }
  }

  Widget _buildLoaded(BuildContext context, Size screenSize, String trainName,
      List<QueryDocumentSnapshot> train, bool isTrain) {
    final data = _data(1);
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(
              (widget.isTrain)
                  ? "assets/icon/fill/train.svg"
                  : "assets/icon/fill/bus.svg",
              height: 300.0,
            ),
          ),
        ),
        CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            _buildAppBar((isTrain) ? train[0]['trainName'] : train[0]['name']),
            TitleContainer(
              trainName: (isTrain) ? train[0]['trainName'] : train[0]['name'],
              data: data,
            ),
            Process(
              processes: train,
              isTrain: isTrain,
            ),
          ],
        ),
      ],
    );
  }
}

// Make self component
class TitleContainer extends StatelessWidget {
  const TitleContainer({Key? key, required this.data, required this.trainName})
      : super(key: key);

  final _TransportInfo data;
  final String trainName;

  @override
  Widget build(BuildContext context) {
    final firstHour =
        int.parse(DateFormat('kk').format(data.processes.first.time));
    final firstMin =
        int.parse(DateFormat('mm').format(data.processes.first.time));
    final lastHour =
        int.parse(DateFormat('kk').format(data.processes.last.time));
    final lastMin =
        int.parse(DateFormat('mm').format(data.processes.last.time));

    final hour = lastHour - firstHour;
    final min = lastMin - firstMin;

    return SliverPadding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 20.0,
      ),
      sliver: SliverToBoxAdapter(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        trainName,
                        style: bHeading7.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        data.classTransport,
                        style: bSubtitle2.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Text(
                    // Change with data
                    'Rp. 25.000',
                    style: bHeading7.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    textAlign: TextAlign.right,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              '${hour.toString()} ${AppLocalizations.of(context)!.hour} ${min.toString()} ${"AppLocalizations.of(context)!.minute"}',
              style: bSubtitle2.copyWith(
                color: Theme.of(context).colorScheme.tertiary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// Make self component
class Process extends StatelessWidget {
  const Process({
    Key? key,
    required this.processes,
    required this.isTrain,
  }) : super(key: key);

  final List<QueryDocumentSnapshot> processes;
  final bool isTrain;
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 20.0,
      ),
      sliver: SliverToBoxAdapter(
        child: FixedTimeline.tileBuilder(
          theme: TimelineThemeData(
            nodePosition: 0,
            indicatorTheme: IndicatorThemeData(
              position: 0,
              size: 20.0,
              color: Theme.of(context).colorScheme.tertiary,
            ),
            connectorTheme: const ConnectorThemeData(
              thickness: 2.5,
              color: bSecondary,
            ),
          ),
          builder: TimelineTileBuilder.connected(
            indicatorBuilder: (_, index) {
              final DateTime now = DateTime.now();
              final DateTime process = processes[index]['date'].toDate();
              if (now.hour >= process.hour) {
                return DotIndicator(
                  color: Theme.of(context).colorScheme.tertiary,
                );
              } else {
                if (now.hour >= process.hour && now.minute >= process.minute) {
                  return DotIndicator(
                    color: Theme.of(context).colorScheme.tertiary,
                  );
                } else {
                  return const OutlinedDotIndicator(
                    color: bGrey,
                    borderWidth: 2.5,
                  );
                }
              }
            },
            connectorBuilder: (_, index, __) {
              final DateTime now = DateTime.now();
              final DateTime process = processes[index]['date'].toDate();
              if (now.hour >= process.hour) {
                return const SolidLineConnector(
                  color: bSecondary,
                );
              } else {
                if (now.hour >= process.hour && now.minute >= process.minute) {
                  return const SolidLineConnector(
                    color: bSecondary,
                  );
                } else {
                  return const DashedLineConnector(
                    gap: 2.0,
                    color: bGrey,
                  );
                }
              }
            },
            contentsBuilder: (context, index) {
              final DateTime now = DateTime.now();
              final DateTime process = processes[index]['date'].toDate();
              final bool isTime =
                  (now.hour >= process.hour && now.minute >= process.minute);
              final bool isTimeHour = (now.hour >= process.hour);
              return Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      DateFormat('h:mm a').format(process),
                      style: bHeading7.copyWith(
                        color: (isTimeHour)
                            ? Theme.of(context).colorScheme.tertiary
                            : (isTime)
                                ? Theme.of(context).colorScheme.tertiary
                                : bGrey,
                      ),
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      (isTrain)
                          ? processes[index]['station']
                          : processes[index]['transit'],
                      style: bSubtitle2.copyWith(
                        color: (isTimeHour)
                            ? Theme.of(context).colorScheme.tertiary
                            : (isTime)
                                ? Theme.of(context).colorScheme.tertiary
                                : bGrey,
                      ),
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
            itemCount: processes.length,
          ),
        ),
      ),
    );
  }
}

_TransportInfo _data(int id) => _TransportInfo(
        id: id,
        price: 25000,
        name: "KA105",
        classTransport: "Ekonomi",
        processes: [
          _Process(
            time: DateTime(1, 1, 1, 11, 6, 0, 0, 0),
            station: "Cimahi (CMI)",
          ),
          _Process(
            time: DateTime(1, 1, 1, 11, 18, 0, 0, 0),
            station: "Cimahi (CMI)",
          ),
          _Process(
            time: DateTime(1, 1, 1, 11, 18, 0, 0, 0),
            station: "Cimahi (CMI)",
          ),
          _Process(
            time: DateTime(1, 1, 1, 11, 18, 0, 0, 0),
            station: "Cimahi (CMI)",
          ),
          _Process(
            time: DateTime(1, 1, 1, 11, 18, 0, 0, 0),
            station: "Cimahi (CMI)",
          ),
          _Process(
            time: DateTime(1, 1, 1, 14, 45, 0, 0, 0),
            station: "Ciroyom (CRM)",
          ),
          _Process(
            time: DateTime(1, 1, 1, 15, 00, 0, 0, 0),
            station: "Bandung (BD)",
          ),
          _Process(
            time: DateTime(1, 1, 1, 15, 15, 0, 0, 0),
            station: "Cikudapateuh (CDP)",
          ),
          _Process(
            time: DateTime(1, 1, 1, 15, 30, 0, 0, 0),
            station: "Kiaracondong (KAC)",
          ),
        ]);

class _TransportInfo {
  const _TransportInfo({
    required this.id,
    required this.price,
    required this.name,
    required this.classTransport,
    required this.processes,
  });

  final int id;
  final int price;
  final String name;
  final String classTransport;
  final List<_Process> processes;
}

class _Process {
  const _Process({
    required this.time,
    required this.station,
  });

  final DateTime time;
  final String station;
}
