import 'package:capstone_design/presentation/components/appbar/custom_sliver_appbar_dashboard.dart';
import 'package:capstone_design/presentation/components/button/custom_primary_icon_text_button.dart';
import 'package:capstone_design/presentation/components/custom_profile_card.dart';
import 'package:capstone_design/presentation/screens/account_detail_screen.dart';
import 'package:capstone_design/presentation/screens/add_umkm_screen.dart';
import 'package:capstone_design/presentation/screens/error_screen.dart';
import 'package:capstone_design/presentation/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

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
          actionIcon: "assets/icon/bell.svg",
          // Must add on Tap
          actionOnTap: () {},
          leading: const Text(
            // Text wait localization
            "Akun",
            textAlign: TextAlign.center,
          ),
          actionIconSecondary: "",
          // Must add on Tap
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
              child: const CustomProfileCard(),
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
              text: 'Keluar',
              // Must add on Tap
              onTap: () {},
              icon: 'assets/icon/log-out.svg',
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
                    MaterialPageRoute(
                      builder: (context) => const AccountDetailScreen(),
                    ),
                  );
                },
                // Text wait localization
                "Detail Akun",
                "assets/icon/user_outline.svg",
              ),
              _buildSmallContainer(
                context,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingScreen(),
                    ),
                  );
                },
                // Text wait localization
                "Pengaturan",
                "assets/icon/settings.svg",
              ),
              _buildSmallContainer(
                context,
                // Must add on Tap
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddUMKMScreen(),
                    ),
                  );
                },
                // Text wait localization
                "Status Registrasi",
                "assets/icon/check-circle.svg",
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
                // Must add on Tap
                () {},
                // Text wait localization
                "Bantuan",
                "assets/icon/question-circle.svg",
              ),
              _buildSmallContainer(
                context,
                // Must add on Tap
                () {},
                // Text wait localization
                "Syarat Ketentuan",
                "assets/icon/file.svg",
              ),
              _buildSmallContainer(
                context,
                // Must add on Tap
                () {},
                // Text wait localization
                "Tentang",
                "assets/icon/info-circle.svg",
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
              children: [
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
              "assets/icon/chevron-right.svg",
              color: bGrey,
              height: 24.0,
            ),
          ],
        ),
      ),
    );
  }
}
