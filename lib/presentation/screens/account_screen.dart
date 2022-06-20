import 'package:capstone_design/presentation/components/appbar/custom_sliver_appbar_dashboard.dart';
import 'package:capstone_design/presentation/components/button/custom_primary_icon_text_button.dart';
import 'package:capstone_design/presentation/components/custom_profile_card.dart';
import 'package:capstone_design/presentation/screens/about_screen.dart';
import 'package:capstone_design/presentation/screens/account_detail_screen.dart';
import 'package:capstone_design/presentation/screens/add_umkm_screen.dart';
import 'package:capstone_design/presentation/screens/error_screen.dart';
import 'package:capstone_design/presentation/screens/news_web_screen.dart';
import 'package:capstone_design/presentation/screens/notifikasi/notifikasi_screen.dart';
import 'package:capstone_design/presentation/screens/setting_screen.dart';
import 'package:capstone_design/presentation/screens/timeline_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:theme/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Review Check 1 (Done)

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

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
      return Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500.0),
          child: _buildAccountScreen(context, screenSize),
        ),
      );
    } else {
      // Mobile Mode
      return _buildAccountScreen(context, screenSize);
    }
  }

  Widget _buildAccountScreen(BuildContext context, Size screenSize) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        CustomSliverAppBarDashboard(
          actionIcon: "assets/icon/regular/bell.svg",
          actionOnTap: () {
            Navigator.push(
              context,
              PageTransition(
                curve: Curves.easeInOut,
                type: PageTransitionType.rightToLeft,
                child: const NotifikasiScreen(),
                duration: const Duration(milliseconds: 250),
                reverseDuration: const Duration(milliseconds: 250),
              ),
            );
          },
          leading: Text(
            // Text wait localization
            AppLocalizations.of(context)!.account,
            textAlign: TextAlign.center,
          ),
          actionIconSecondary: "",
          actionOnTapSecondary: () {},
          // Becarefull with this
          isDoubleAction: false,
        ),
        SliverPadding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            bottom: 20.0,
            top: 10.0,
          ),
          sliver: SliverToBoxAdapter(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: const CustomProfileCard(
                email: "Batur@gmail.com",
                name: "Neida Aleida",
                profilePic:
                    "https://akcdn.detik.net.id/api/wm/2020/03/13/60cf74a7-8cc1-4a24-8f9d-0772471f9fb1_169.jpeg",
                username: "bandungtourism",
              ),
            ),
          ),
        ),
        _buildContainerOne(context, screenSize),
        _buildContainerTwo(context, screenSize),
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 30.0,
          ),
          sliver: SliverToBoxAdapter(
            child: CustomPrimaryIconTextButton(
              width: screenSize.width,
              // Text wait localization
              text: AppLocalizations.of(context)!.logout,
              // Must add on Tap
              onTap: () {},
              icon: "assets/icon/bold/log-out.svg",
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContainerOne(BuildContext context, Size screenSize) {
    return SliverPadding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 10.0,
      ),
      sliver: SliverToBoxAdapter(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            children: <Widget>[
              _buildSmallContainer(
                context,
                () {
                  Navigator.push(
                    context,
                    PageTransition(
                      curve: Curves.easeInOut,
                      type: PageTransitionType.bottomToTop,
                      child: const AccountDetailScreen(),
                      duration: const Duration(milliseconds: 150),
                      reverseDuration: const Duration(milliseconds: 150),
                    ),
                  );
                },
                // Text wait localization
                AppLocalizations.of(context)!.accountDetail,
                "assets/icon/regular/user.svg",
              ),
              _buildSmallContainer(
                context,
                () {
                  Navigator.push(
                    context,
                    PageTransition(
                      curve: Curves.easeInOut,
                      type: PageTransitionType.bottomToTop,
                      child: const SettingScreen(),
                      duration: const Duration(milliseconds: 150),
                      reverseDuration: const Duration(milliseconds: 150),
                    ),
                  );
                },
                // Text wait localization
                AppLocalizations.of(context)!.setting,
                "assets/icon/regular/settings.svg",
              ),
              _buildSmallContainer(
                context,
                () {
                  Navigator.push(
                    context,
                    PageTransition(
                      curve: Curves.easeInOut,
                      type: PageTransitionType.bottomToTop,
                      child: const AddUMKMScreen(),
                      duration: const Duration(milliseconds: 150),
                      reverseDuration: const Duration(milliseconds: 150),
                    ),
                  );
                },
                // Text wait localization
                AppLocalizations.of(context)!.registrationStatus,
                "assets/icon/regular/check-circle.svg",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContainerTwo(BuildContext context, Size screenSize) {
    return SliverPadding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 20.0,
      ),
      sliver: SliverToBoxAdapter(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            children: <Widget>[
              _buildSmallContainer(
                context,
                () {
                  Navigator.push(
                    context,
                    PageTransition(
                      curve: Curves.easeInOut,
                      type: PageTransitionType.bottomToTop,
                      child: const NewsWebScreen(),
                      duration: const Duration(milliseconds: 150),
                      reverseDuration: const Duration(milliseconds: 150),
                    ),
                  );
                },
                // Text wait localization
                AppLocalizations.of(context)!.help,
                "assets/icon/regular/question-circle.svg",
              ),
              _buildSmallContainer(
                context,
                () {
                  Navigator.push(
                    context,
                    PageTransition(
                      curve: Curves.easeInOut,
                      type: PageTransitionType.bottomToTop,
                      child: const TimeLineScreen(),
                      duration: const Duration(milliseconds: 150),
                      reverseDuration: const Duration(milliseconds: 150),
                    ),
                  );
                },
                // Text wait localization
                AppLocalizations.of(context)!.termsAndConditions,
                "assets/icon/regular/file.svg",
              ),
              _buildSmallContainer(
                context,
                () {
                  Navigator.push(
                    context,
                    PageTransition(
                      curve: Curves.easeInOut,
                      type: PageTransitionType.bottomToTop,
                      child: const AboutScreen(),
                      duration: const Duration(milliseconds: 150),
                      reverseDuration: const Duration(milliseconds: 150),
                    ),
                  );
                },
                // Text wait localization
                AppLocalizations.of(context)!.about,
                "assets/icon/regular/info-circle.svg",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSmallContainer(
    BuildContext context,
    Function() onTap,
    String title,
    String icon,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                SvgPicture.asset(
                  icon,
                  color: Theme.of(context).colorScheme.tertiary,
                  height: 24.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    title,
                    style: bSubtitle2.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ),
              ],
            ),
            SvgPicture.asset(
              "assets/icon/regular/chevron-right.svg",
              color: bGrey,
              height: 24.0,
            ),
          ],
        ),
      ),
    );
  }
}
