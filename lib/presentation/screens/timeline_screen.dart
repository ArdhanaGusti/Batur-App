import 'package:capstone_design/presentation/components/appbar/custom_sliver_appbar_text_leading.dart';
import 'package:capstone_design/presentation/screens/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:theme/theme.dart';
import 'package:timelines/timelines.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TimeLineScreen extends StatelessWidget {
  const TimeLineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 320.0 || screenSize.height < 650.0) {
      return ErrorScreen(
        // Text wait localization
        title: AppLocalizations.of(context)!.screenError,
        message: AppLocalizations.of(context)!.screenSmall,
      );
    } else if (screenSize.width > 500.0) {
      // Tablet Mode (Must be repair)
      return Scaffold(
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500.0),
            child: _buildNewsDetailScreen(context, screenSize),
          ),
        ),
      );
    } else {
      // Mobile Mode
      return Scaffold(
        body: _buildNewsDetailScreen(context, screenSize),
      );
    }
  }

  Widget _buildNewsDetailScreen(BuildContext context, Size screenSize) {
    final data = _data(1);
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(
              "assets/icon/fill/train.svg",
              height: 300.0,
            ),
          ),
        ),
        CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            CustomSliverAppBarTextLeading(
              // Text wait localization
              title: "KA 105",
              leadingIcon: "assets/icon/back.svg",
              // Navigation repair
              leadingOnTap: () {
                Navigator.pop(
                  context,
                );
              },
            ),
            TitleContainer(
              data: data,
            ),
            Process(processes: data.processes),
          ],
        ),
      ],
    );
  }
}

class TitleContainer extends StatelessWidget {
  const TitleContainer({Key? key, required this.data}) : super(key: key);
  final _TransportInfo data;

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  data.name,
                  style: bHeading7.copyWith(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  data.classTransport,
                  style: bSubtitle2.copyWith(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  '${hour.toString()} ${AppLocalizations.of(context)!.hour} ${min.toString()} ${AppLocalizations.of(context)!.minute}',
                  style: bSubtitle2.copyWith(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Text(
              'Rp. 25.000',
              style: bHeading7.copyWith(
                color: Theme.of(context).colorScheme.tertiary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class Process extends StatelessWidget {
  const Process({Key? key, required this.processes}) : super(key: key);

  final List<_Process> processes;
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
              final DateTime process = processes[index].time;
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
              final DateTime process = processes[index].time;
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
              final DateTime process = processes[index].time;
              final bool isTime =
                  (now.hour >= process.hour && now.minute >= process.minute);
              final bool isTimeHour = (now.hour >= process.hour);
              return Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      DateFormat('kk:mm').format(process),
                      style: bHeading7.copyWith(
                        color: (isTimeHour)
                            ? Theme.of(context).colorScheme.tertiary
                            : (isTime)
                                ? Theme.of(context).colorScheme.tertiary
                                : bGrey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      processes[index].station,
                      style: bSubtitle2.copyWith(
                        color: (isTimeHour)
                            ? Theme.of(context).colorScheme.tertiary
                            : (isTime)
                                ? Theme.of(context).colorScheme.tertiary
                                : bGrey,
                      ),
                      textAlign: TextAlign.center,
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
