import 'package:capstone_design/presentation/components/appbar/custom_sliver_appbar_text_leading.dart';
import 'package:capstone_design/presentation/screens/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThemeSettingScreen extends StatelessWidget {
  const ThemeSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 320.0 || screenSize.height < 600.0) {
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
            child: _buildThemeScreen(context, screenSize),
          ),
        ),
      );
    } else {
      // Mobile Mode
      return Scaffold(
        body: _buildThemeScreen(context, screenSize),
      );
    }
  }

  Widget _buildThemeScreen(BuildContext context, Size screenSize) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        CustomSliverAppBarTextLeading(
          // Text wait localization
          title: AppLocalizations.of(context)!.displayMode,
          leadingIcon: "assets/icon/back.svg",
          // Navigation repair
          leadingOnTap: () {
            Navigator.pop(
              context,
            );
          },
        ),
        _customTheme(context),
      ],
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
                AppLocalizations.of(context)!.themeDesc,
                style: bSubtitle2.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                child: _customDivider(),
              ),
              _customListTileTheme(
                context,
                ThemeModeEnum.lightTheme,
                // Text wait localization
                AppLocalizations.of(context)!.light,
              ),
              _customListTileTheme(
                context,
                ThemeModeEnum.darkTheme,
                // Text wait localization
                AppLocalizations.of(context)!.dark,
              ),
              _customListTileTheme(
                context,
                ThemeModeEnum.systemTheme,
                // Text wait localization
                AppLocalizations.of(context)!.system,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0, top: 10.0),
                child: _customDivider(),
              ),
              Text(
                // Text wait localization
                AppLocalizations.of(context)!.ifLayoutSystem,
                style: bBody1.copyWith(
                  color: bGrey,
                ),
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
        return GestureDetector(
          onTap: () {
            _themeChange(
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
              Radio<ThemeModeEnum>(
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
