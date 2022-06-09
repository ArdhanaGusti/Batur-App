import 'package:capstone_design/presentation/bloc/notification_bloc.dart';
import 'package:capstone_design/presentation/components/appbar/custom_sliver_appbar_text_leading.dart';
import 'package:capstone_design/presentation/screens/error_screen.dart';
import 'package:capstone_design/utils/enum/notification_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme/theme.dart';

class NotificationSettingScreen extends StatelessWidget {
  const NotificationSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 320.0 || screenSize.height < 650.0) {
      return const ErrorScreen(
        // Text wait localization
        title: "Error Layar",
        message: "Aduh, Layar anda terlalu kecil",
      );
    } else if (screenSize.width > 500.0) {
      // Tablet Mode (Must be repair)
      return Scaffold(
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500.0),
            child: _buildNotifScreen(context, screenSize),
          ),
        ),
      );
    } else {
      // Mobile Mode
      return Scaffold(
        body: _buildNotifScreen(context, screenSize),
      );
    }
  }

  Widget _buildNotifScreen(BuildContext context, Size screenSize) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        CustomSliverAppBarTextLeading(
          // Text wait localization
          title: "Notifikasi",
          leadingIcon: "assets/icon/back.svg",
          // Navigation repair
          leadingOnTap: () {
            Navigator.pop(
              context,
            );
          },
        ),
        _customNotif(context),
      ],
    );
  }

  void _notifChange(NotificationEnum notif, BuildContext context) {
    context.read<NotificationBloc>().add(
          SaveNotificationMode(
            notif: notif,
          ),
        );
  }

  Widget _customNotif(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            children: <Widget>[
              Text(
                // Text wait localization
                "Pilih pengaturan notifikasi di aplikasi Bandung Tourism Anda pada perangkat ini.",
                style: bSubtitle2.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                child: _customDivider(),
              ),
              _customListTileNotif(
                context,
                NotificationEnum.off,
                // Text wait localization
                "Nonaktif",
              ),
              _customListTileNotif(
                context,
                NotificationEnum.on,
                // Text wait localization
                "Aktif",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customListTileNotif(
    BuildContext context,
    NotificationEnum value,
    String title,
  ) {
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            _notifChange(
              value,
              context,
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: bSubtitle2.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              Radio<NotificationEnum>(
                fillColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.tertiary,
                ),
                value: value,
                groupValue: state.notif,
                onChanged: (value) => _notifChange(
                  value!,
                  context,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Divider _customDivider() {
    return const Divider(
      height: 0,
      thickness: 1.0,
      indent: 10.0,
      endIndent: 10.0,
      color: bStroke,
    );
  }
}
