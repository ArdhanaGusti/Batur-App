import 'package:account/presentation/bloc/language_bloc.dart';
import 'package:account/utils/enum/language_enum.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme/theme.dart';

class LanguageSettingScreen extends StatelessWidget {
  const LanguageSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 320.0 || screenSize.height < 650.0) {
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
            child: _buildLanguageScreen(context, screenSize),
          ),
        ),
      );
    } else {
      // Mobile Mode
      return Scaffold(
        body: _buildLanguageScreen(context, screenSize),
      );
    }
  }

  Widget _buildLanguageScreen(BuildContext context, Size screenSize) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        CustomSliverAppBarTextLeading(
          // Text wait localization
          title: "AppLocalizations.of(context)!.language",
          leadingIcon: "assets/icon/back.svg",
          // Navigation repair
          leadingOnTap: () {
            Navigator.pop(
              context,
            );
          },
        ),
        _customLanguage(context),
      ],
    );
  }

  void _languageChange(LanguageEnum language, BuildContext context) {
    context.read<LanguageBloc>().add(
          SaveLanguageMode(
            language: language,
          ),
        );
  }

  Widget _customLanguage(BuildContext context) {
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
                "AppLocalizations.of(context)!.selectLanguage",
                style: bSubtitle2.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                child: _customDivider(),
              ),
              _customListTileLanguage(
                context,
                LanguageEnum.indonesia,
                // Text wait localization
                "AppLocalizations.of(context)!.indonesia",
              ),
              _customListTileLanguage(
                context,
                LanguageEnum.england,
                // Text wait localization
                "AppLocalizations.of(context)!.inggris",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customListTileLanguage(
    BuildContext context,
    LanguageEnum value,
    String title,
  ) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            _languageChange(
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
              Radio<LanguageEnum>(
                fillColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.tertiary,
                ),
                value: value,
                groupValue: state.language,
                onChanged: (value) => _languageChange(
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
