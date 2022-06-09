import 'package:capstone_design/presentation/components/appbar/custom_sliver_appbar_text_leading.dart';
import 'package:capstone_design/presentation/screens/error_screen.dart';
import 'package:capstone_design/presentation/screens/theme_setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

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
          title: "Pengaturan",
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
                  _customTextContainer(
                    context,
                    // Text wait localization
                    "Notifikasi",
                    // Parameter use Bloc
                    "Neida Aleida",
                    "assets/icon/bell.svg",
                  ),
                  _customDivider(),
                  _customTextContainer(
                    context,
                    // Text wait localization
                    "Bahasa",
                    // Parameter use Bloc
                    "neidaaleida",
                    "assets/icon/globe.svg",
                  ),
                  _customDivider(),
                  BlocBuilder<ThemeManagerBloc, ThemeManagerState>(
                    builder: (context, state) {
                      String mode = (state.isDark == ThemeModeEnum.lightTheme)
                          ? "Terang"
                          : (state.isDark == ThemeModeEnum.darkTheme)
                              ? "Gelap"
                              : "Sistem";
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
                          "Mode Tampilan",
                          // Parameter use Bloc
                          mode,
                          "assets/icon/mode.svg",
                        ),
                      );
                    },
                  ),
                  // Display Password with Obsecure
                ],
              ),
            ),
          ),
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
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Notifikasi",
                      style: bSubtitle2.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ),
                  const Divider(
                    height: 0,
                    thickness: 1.0,
                    indent: 20.0,
                    endIndent: 20.0,
                    color: bStroke,
                  ),
                  ListTile(
                    title: Text(
                      "Hidup",
                      style: bBody1.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    leading: Radio<bool>(
                      value: false,
                      groupValue: true,
                      onChanged: (value) {},
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Mati",
                      style: bBody1.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    leading: Radio<bool>(
                      value: false,
                      groupValue: true,
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
            ),
          ),
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
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Bahasa",
                      style: bSubtitle2.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ),
                  const Divider(
                    height: 0,
                    thickness: 1.0,
                    indent: 20.0,
                    endIndent: 20.0,
                    color: bStroke,
                  ),
                  ListTile(
                    title: Text(
                      "Indonesia",
                      style: bBody1.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    leading: Radio<bool>(
                      value: false,
                      groupValue: true,
                      onChanged: (value) {},
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Inggris",
                      style: bBody1.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    leading: Radio<bool>(
                      value: false,
                      groupValue: true,
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        _customTheme(context),
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
                Text(
                  title,
                  style: bSubtitle4.copyWith(
                    color: Theme.of(context).colorScheme.tertiary,
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

  void _themeChange(ThemeModeEnum mode, BuildContext context) {
    context.read<ThemeManagerBloc>().add(
          SaveThemeMode(
            isDark: mode,
          ),
        );
  }

  Widget _customTheme(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(
        top: 30.0,
        left: 20.0,
        right: 20.0,
      ),
      sliver: SliverToBoxAdapter(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Pilih Mode tampilan aplikasi Bandung Tourism anda pada perangkat ini",
                  style: bSubtitle2.copyWith(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
              _customDivider(),
              _customListTileTheme(
                context,
                ThemeModeEnum.lightTheme,
                "Mode Terang",
              ),
              _customListTileTheme(
                context,
                ThemeModeEnum.darkTheme,
                "Mode Gelap",
              ),
              _customListTileTheme(
                context,
                ThemeModeEnum.systemTheme,
                "Sistem",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customListTileTheme(
    BuildContext context,
    ThemeModeEnum value,
    String title,
  ) {
    return BlocBuilder<ThemeManagerBloc, ThemeManagerState>(
      builder: (context, state) {
        return ListTile(
          dense: true,
          contentPadding: const EdgeInsets.all(0),
          title: Text(
            title,
            style: bBody1.copyWith(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          leading: Radio<ThemeModeEnum>(
            fillColor: MaterialStateProperty.all(
              Theme.of(context).colorScheme.tertiary,
            ),
            value: value,
            groupValue: state.isDark,
            onChanged: (value) => _themeChange(
              value!,
              context,
            ),
          ),
        );
      },
    );
  }

  Divider _customDivider() {
    return const Divider(
      height: 0,
      thickness: 1.0,
      indent: 20.0,
      endIndent: 20.0,
      color: bStroke,
    );
  }
}
