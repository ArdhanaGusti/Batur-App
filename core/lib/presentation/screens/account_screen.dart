import 'package:core/presentation/components/appbar/custom_sliver_appbar_dashboard.dart';
import 'package:core/presentation/components/button/custom_primary_icon_text_button.dart';
import 'package:core/presentation/components/custom_profile_card.dart';
import 'package:core/presentation/screens/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:theme/theme.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Review Check 1 (Done)

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 320.0 || screenSize.height < 600.0) {
      return const ErrorScreen(
        // Text wait localization
        title: "Eror",
        message: "Eror",
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
            // Navigator.push(
            //   context,
            //   PageTransition(
            //     curve: Curves.easeInOut,
            //     type: PageTransitionType.rightToLeft,
            //     child: const NotificationScreen(),
            //     duration: const Duration(milliseconds: 150),
            //     reverseDuration: const Duration(milliseconds: 150),
            //   ),
            // );
          },
          leading: const Text(
            // Text wait localization
            "AKun",
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
              // Fetch from Firebase
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
        _buildContainer(
          context,
          screenSize,
          <Widget>[
            _buildSmallContainer(
              context,
              () {
                // Navigator.push(
                //   context,
                //   PageTransition(
                //     curve: Curves.easeInOut,
                //     type: PageTransitionType.bottomToTop,
                //     child: const AccountDetailScreen(),
                //     duration: const Duration(milliseconds: 150),
                //     reverseDuration: const Duration(milliseconds: 150),
                //   ),
                // );
              },
              // Text wait localization
              "Detail Akun",
              "assets/icon/regular/user.svg",
            ),
            _buildSmallContainer(
              context,
              () {
                // Navigator.push(
                //   context,
                //   PageTransition(
                //     curve: Curves.easeInOut,
                //     type: PageTransitionType.bottomToTop,
                //     child: const SettingScreen(),
                //     duration: const Duration(milliseconds: 150),
                //     reverseDuration: const Duration(milliseconds: 150),
                //   ),
                // );
              },
              // Text wait localization
              "Pengaturan",
              "assets/icon/regular/settings.svg",
            ),
            _buildSmallContainer(
              context,
              () {
                // Navigator.push(
                //   context,
                //   PageTransition(
                //     curve: Curves.easeInOut,
                //     type: PageTransitionType.bottomToTop,
                //     child: const AddUMKMScreen(),
                //     duration: const Duration(milliseconds: 150),
                //     reverseDuration: const Duration(milliseconds: 150),
                //   ),
                // );
              },
              // Text wait localization
              "Status Registrasi",
              "assets/icon/regular/check-circle.svg",
            ),
          ],
        ),
        _buildContainer(
          context,
          screenSize,
          <Widget>[
            _buildSmallContainer(
              context,
              () {
                // Navigator.push(
                //   context,
                //   PageTransition(
                //     curve: Curves.easeInOut,
                //     type: PageTransitionType.bottomToTop,
                //     child: const NewsWebScreen(),
                //     duration: const Duration(milliseconds: 150),
                //     reverseDuration: const Duration(milliseconds: 150),
                //   ),
                // );
              },
              // Text wait localization
              "Bantuan",
              "assets/icon/regular/question-circle.svg",
            ),
            _buildSmallContainer(
              context,
              () {
                // Navigator.push(
                //   context,
                //   PageTransition(
                //     curve: Curves.easeInOut,
                //     type: PageTransitionType.bottomToTop,
                //     child: const TimeLineScreen(),
                //     duration: const Duration(milliseconds: 150),
                //     reverseDuration: const Duration(milliseconds: 150),
                //   ),
                // );
              },
              // Text wait localization
              "Term an Condition",
              "assets/icon/regular/file.svg",
            ),
            _buildSmallContainer(
              context,
              () {
                // Navigator.push(
                //   context,
                //   PageTransition(
                //     curve: Curves.easeInOut,
                //     type: PageTransitionType.bottomToTop,
                //     child: const AboutScreen(),
                //     duration: const Duration(milliseconds: 150),
                //     reverseDuration: const Duration(milliseconds: 150),
                //   ),
                // );
              },
              // Text wait localization
              "Tentang",
              "assets/icon/regular/info-circle.svg",
            ),
          ],
        ),
        SliverPadding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 20.0,
            bottom: 30.0,
          ),
          sliver: SliverToBoxAdapter(
            child: CustomPrimaryIconTextButton(
              width: screenSize.width,
              // Text wait localization
              text: "Keluar",
              // Must add on Tap
              onTap: () {},
              icon: "assets/icon/bold/log-out.svg",
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContainer(
    BuildContext context,
    Size screenSize,
    List<Widget> list,
  ) {
    return SliverPadding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 10.0,
        bottom: 10.0,
      ),
      sliver: SliverToBoxAdapter(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(children: list),
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
          crossAxisAlignment: CrossAxisAlignment.center,
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
