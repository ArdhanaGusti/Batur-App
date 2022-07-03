import 'package:core/presentation/components/appbar/custom_sliver_appbar_text_leading.dart';
import 'package:core/presentation/screens/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Check

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 300.0 || screenSize.height < 600.0) {
      return ErrorScreen(
        // Text wait localization
        title: AppLocalizations.of(context)!.oops,
        message: AppLocalizations.of(context)!.screenError,
      );
    } else {
      // Mobile Mode
      return Scaffold(
        body: _buildHelpScreen(context, screenSize),
      );
    }
  }

  Widget _buildHelpScreen(BuildContext context, Size screenSize) {
    Brightness screenBrightness = MediaQuery.platformBrightnessOf(context);

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        CustomSliverAppBarTextLeading(
          // Text wait localization
          title: AppLocalizations.of(context)!.help,
          leadingIcon: "assets/icon/regular/chevron-left.svg",
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
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: <Widget>[
                  Center(
                    child: BlocBuilder<ThemeManagerBloc, ThemeManagerState>(
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
                          height: 60.0,
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Center(
                    // Text wait localization
                    child: Text(
                      "Versi 1.0.0",
                      style: bSubtitle4.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    // Text wait localization
                    child: Text(
                      AppLocalizations.of(context)!.helpDesc,
                      style: bSubtitle1.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Center(
                    // Text wait localization
                    child: Text(
                      AppLocalizations.of(context)!.developmentTeam,
                      style: bSubtitle3.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    // Text wait localization
                    child: Text(
                      "- P2012A055 - Hafid Ikhsan Arifin",
                      style: bSubtitle1.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Center(
                    // Text wait localization
                    child: Text(
                      "p2012a055@dicoding.org",
                      style: bSubtitle3.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
