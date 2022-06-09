import 'package:capstone_design/presentation/components/appbar/custom_appbar_title_notification.dart';
import 'package:capstone_design/presentation/components/button/custom_primary_icon_text_button.dart';
import 'package:capstone_design/presentation/components/custom_profile_card.dart';
import 'package:capstone_design/presentation/screens/account_detail_screen.dart';
import 'package:capstone_design/presentation/screens/dashboard_screen.dart';
import 'package:capstone_design/presentation/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        children: <Widget>[
          Material(
            elevation: 2.0,
            color: Theme.of(context).colorScheme.background,
            child: const CustomAppBarTitleNotification(
              title: 'Akun',
            ),
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: const CustomProfileCard(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const AccountDetailScreen(),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/icon/user_outline.svg",
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                            height: 24.0,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: Text(
                                              "Detail Akun",
                                              style: bSubtitle2.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SvgPicture.asset(
                                        "assets/icon/chevron-right.svg",
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                        height: 24.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(
                                height: 0,
                                thickness: 1,
                                indent: 25,
                                endIndent: 25,
                                color: bStroke,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SettingScreen(),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/icon/settings.svg",
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                            height: 24.0,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: Text(
                                              "Pengaturan",
                                              style: bSubtitle2.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SvgPicture.asset(
                                        "assets/icon/chevron-right.svg",
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                        height: 24.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(
                                height: 0,
                                thickness: 1,
                                indent: 25,
                                endIndent: 25,
                                color: bStroke,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icon/check-circle.svg",
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          height: 24.0,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Text(
                                            "Status Registrasi",
                                            style: bSubtitle2.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .tertiary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SvgPicture.asset(
                                      "assets/icon/chevron-right.svg",
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      height: 24.0,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icon/question-circle.svg",
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          height: 24.0,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Text(
                                            "Bantuan",
                                            style: bSubtitle2.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .tertiary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SvgPicture.asset(
                                      "assets/icon/chevron-right.svg",
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      height: 24.0,
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 0,
                                thickness: 1,
                                indent: 25,
                                endIndent: 25,
                                color: bStroke,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icon/file.svg",
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          height: 24.0,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Text(
                                            "Syarat Ketentuan",
                                            style: bSubtitle2.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .tertiary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SvgPicture.asset(
                                      "assets/icon/chevron-right.svg",
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      height: 24.0,
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 0,
                                thickness: 1,
                                indent: 25,
                                endIndent: 25,
                                color: bStroke,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icon/info-circle.svg",
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          height: 24.0,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Text(
                                            "Tentang",
                                            style: bSubtitle2.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .tertiary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SvgPicture.asset(
                                      "assets/icon/chevron-right.svg",
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      height: 24.0,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30.0),
                        child: CustomPrimaryIconTextButton(
                          width: screenSize.width,
                          // Text wait localization
                          text: 'Keluar',
                          onTap: () {
                            // On tap must be replace
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DashboardScreen(),
                              ),
                            );
                          },
                          icon: 'assets/icon/log-out.svg',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
