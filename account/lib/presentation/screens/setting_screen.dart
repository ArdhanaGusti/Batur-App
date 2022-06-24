import 'package:account/account.dart';
import 'package:account/presentation/screens/language_setting_screen.dart';
import 'package:account/presentation/screens/notification_setting_screen.dart';
import 'package:account/presentation/screens/theme_setting_screen.dart';
import 'package:account/utils/enum/language_enum.dart';
import 'package:account/utils/enum/notification_enum.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 320.0 || screenSize.height < 600.0) {
      return const ErrorScreen(
        // Text wait localization
        title: "AppLocalizations.of(context)!.screenError",
        message: "AppLocalizations.of(context)!.screenSmall",
      );
    } else if (screenSize.width > 500.0) {
      // Tablet Mode (Must be repair)
      return Scaffold(
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500.0),
            child: _buildSettingScreen(context, screenSize),
          ),
        ),
      );
    } else {
      // Mobile Mode
      return Scaffold(
        body: _buildSettingScreen(context, screenSize),
      );
    }
  }

  Widget _buildSettingScreen(BuildContext context, Size screenSize) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        CustomSliverAppBarTextLeading(
          // Text wait localization
          title: "AppLocalizations.of(context)!.setting",
          leadingIcon: "assets/icon/back.svg",
          // Navigation repair
          leadingOnTap: () {
            Navigator.pop(
              context,
            );
          },
        ),
        SliverPadding(
          padding: const EdgeInsets.all(20.0),
          sliver: SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: <Widget>[
                  BlocBuilder<NotificationBloc, NotificationState>(
                    builder: (context, state) {
                      String mode = (state.notif == NotificationEnum.off)
                          ? "AppLocalizations.of(context)!.disable"
                          : "AppLocalizations.of(context)!.enable";
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const NotificationSettingScreen(),
                            ),
                          );
                        },
                        child: _customTextContainer(
                          context,
                          // Text wait localization
                          "AppLocalizations.of(context)!.notification",
                          // Parameter use Bloc
                          mode,
                          "assets/icon/bell-Light.svg",
                        ),
                      );
                    },
                  ),
                  _customDivider(),
                  BlocBuilder<LanguageBloc, LanguageState>(
                    builder: (context, state) {
                      String mode = (state.language == LanguageEnum.indonesia)
                          ? "AppLocalizations.of(context)!.indonesia"
                          : "AppLocalizations.of(context)!.inggris";
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const LanguageSettingScreen(),
                            ),
                          );
                        },
                        child: _customTextContainer(
                          context,
                          // Text wait localization
                          "AppLocalizations.of(context)!.language",
                          // Parameter use Bloc
                          mode,
                          "assets/icon/globe.svg",
                        ),
                      );
                    },
                  ),
                  _customDivider(),
                  BlocBuilder<ThemeManagerBloc, ThemeManagerState>(
                    builder: (context, state) {
                      String mode = (state.isDark == ThemeModeEnum.lightTheme)
                          ? "AppLocalizations.of(context)!.light"
                          : (state.isDark == ThemeModeEnum.darkTheme)
                              ? "AppLocalizations.of(context)!.dark"
                              : "AppLocalizations.of(context)!.sistem";
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ThemeSettingScreen(),
                            ),
                          );
                        },
                        child: _customTextContainer(
                          context,
                          // Text wait localization
                          "AppLocalizations.of(context)!.displayMode",
                          // Parameter use Bloc
                          mode,
                          "assets/icon/mode.svg",
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _customTextContainer(
    BuildContext context,
    String title,
    String value,
    String icon,
  ) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: SvgPicture.asset(
                    icon,
                    color: Theme.of(context).colorScheme.tertiary,
                    height: 24.0,
                  ),
                ),
                Flexible(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: bSubtitle4.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    value,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                    style: bSubtitle2.copyWith(
                      color: bGrey,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: SvgPicture.asset(
                    "assets/icon/chevron-right.svg",
                    color: bGrey,
                    height: 24.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Divider _customDivider() {
    return const Divider(
      height: 0,
      thickness: 1.0,
      indent: 30.0,
      endIndent: 30.0,
      color: bStroke,
    );
  }
}
