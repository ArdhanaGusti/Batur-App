import 'package:account/account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:theme/theme.dart';
import 'package:umkm/umkm.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Check

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  User user = FirebaseAuth.instance.currentUser!;

  void _signOut() {
    context.read<DashboardBloc>().add(const SingOut());
    context.read<DashboardBloc>().add(const IsLogInSave(value: false));
    context.read<DashboardBloc>().add(const IsAdminSave(value: false));
    context.read<DashboardBloc>().add(const OnIsHaveProfileSave(value: false));
    context.read<DashboardBloc>().add(const OnSaveRemembermeDashboard());
  }

  @override
  void initState() {
    context.read<DashboardBloc>().add(OnIsHaveProfile(email: user.email!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 300.0 || screenSize.height < 600.0) {
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
        BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            return CustomSliverAppBarDashboard(
              actionIcon: "assets/icon/regular/bell.svg",
              actionOnTap: () {
                if (state.isHaveProfile) {
                  Navigator.push(
                    context,
                    PageTransition(
                      curve: Curves.easeInOut,
                      type: PageTransitionType.rightToLeft,
                      child: const NotificationScreen(),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    PageTransition(
                      curve: Curves.easeInOut,
                      type: PageTransitionType.bottomToTop,
                      child: const RegistrationSettingScreen(),
                    ),
                  );
                }
              },
              leading: Text(
                AppLocalizations.of(context)!.account,
                textAlign: TextAlign.center,
              ),
              actionIconSecondary: "",
              actionOnTapSecondary: () {},
              // Becarefull with this
              isDoubleAction: false,
            );
          },
        ),
        SliverPadding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            bottom: 20.0,
            top: 10.0,
          ),
          sliver: SliverToBoxAdapter(
            child: BlocBuilder<DashboardBloc, DashboardState>(
              builder: (context, state) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  // Fetch from Firebase
                  child: (state.isHaveProfile)
                      ? StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("Profile")
                              .where("email",
                                  isEqualTo:
                                      FirebaseAuth.instance.currentUser!.email)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Container(
                                height: 180.0,
                                color: Theme.of(context).colorScheme.surface,
                                child: Center(
                                  child: LoadingAnimationWidget
                                      .horizontalRotatingDots(
                                    color: bTextPrimary,
                                    size: 30.0,
                                  ),
                                ),
                              );
                            } else if (snapshot.data!.size == 0) {
                              return const CustomProfileCard(
                                email: "Batur@gmail.com",
                                name: "Error",
                                profilePic:
                                    "https://akcdn.detik.net.id/api/wm/2020/03/13/60cf74a7-8cc1-4a24-8f9d-0772471f9fb1_169.jpeg",
                                username: "bandungtourism",
                              );
                            } else {
                              var profile = snapshot.data!.docs;
                              var profile1 = profile[0]['imgUrl'];
                              return CustomProfileCard(
                                email: snapshot.data!.docs[0]['email'],
                                name: snapshot.data!.docs[0]['fullname'],
                                profilePic: profile1,
                                username: snapshot.data!.docs[0]['username'],
                              );
                            }
                          },
                        )
                      : GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                curve: Curves.easeInOut,
                                type: PageTransitionType.bottomToTop,
                                child: const RegistrationSettingScreen(),
                              ),
                            );
                          },
                          child: Container(
                            height: 180.0,
                            color: Theme.of(context).colorScheme.surface,
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!.youHaveProfile,
                                overflow: TextOverflow.ellipsis,
                                style: bSubtitle2.copyWith(
                                  color: bTextPrimary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                );
              },
            ),
          ),
        ),
        _buildContainer(
          context,
          screenSize,
          <Widget>[
            BlocBuilder<DashboardBloc, DashboardState>(
              builder: (context, state) {
                if (state.isHaveProfile) {
                  return _buildSmallContainer(
                    context,
                    () {
                      // Navigate to Detail Page
                      Navigator.push(
                        context,
                        PageTransition(
                          curve: Curves.easeInOut,
                          type: PageTransitionType.leftToRight,
                          child: const AccountDetailScreen(),
                        ),
                      );
                    },
                    // Text wait localization
                    AppLocalizations.of(context)!.accountDetail,
                    "assets/icon/regular/user.svg",
                  );
                } else {
                  return _buildSmallContainer(
                    context,
                    () {
                      // Navigate to Detail Page
                      Navigator.push(
                        context,
                        PageTransition(
                          curve: Curves.easeInOut,
                          type: PageTransitionType.bottomToTop,
                          child: const RegistrationSettingScreen(),
                        ),
                      );
                    },
                    // Text wait localization
                    AppLocalizations.of(context)!.accountDetail,
                    "assets/icon/regular/user.svg",
                  );
                }
              },
            ),
            _buildSmallContainer(
              context,
              () {
                // Navigate to Setting Page
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
              AppLocalizations.of(context)!.settings,
              "assets/icon/regular/settings.svg",
            ),
            BlocBuilder<DashboardBloc, DashboardState>(
              builder: (context, state) {
                if (state.isHaveProfile) {
                  if (state.isAdmin) {
                    return _buildSmallContainer(
                      context,
                      () {
                        Navigator.push(
                          context,
                          PageTransition(
                            curve: Curves.easeInOut,
                            type: PageTransitionType.rightToLeft,
                            child: const StatusRegisterUmkmAdminScreen(),
                            duration: const Duration(milliseconds: 150),
                            reverseDuration: const Duration(milliseconds: 150),
                          ),
                        );
                      },
                      // Text wait localization
                      AppLocalizations.of(context)!.registrationStatus,
                      "assets/icon/regular/check-circle.svg",
                    );
                  } else {
                    return _buildSmallContainer(
                      context,
                      () {
                        Navigator.push(
                          context,
                          PageTransition(
                            curve: Curves.easeInOut,
                            type: PageTransitionType.rightToLeft,
                            child: const StatusRegisterUmkmScreen(),
                            duration: const Duration(milliseconds: 150),
                            reverseDuration: const Duration(milliseconds: 150),
                          ),
                        );
                      },
                      // Text wait localization
                      AppLocalizations.of(context)!.registrationStatus,
                      "assets/icon/regular/check-circle.svg",
                    );
                  }
                } else {
                  return _buildSmallContainer(
                    context,
                    () {
                      Navigator.push(
                        context,
                        PageTransition(
                          curve: Curves.easeInOut,
                          type: PageTransitionType.bottomToTop,
                          child: const RegistrationSettingScreen(),
                        ),
                      );
                    },
                    // Text wait localization
                    AppLocalizations.of(context)!.registrationStatus,
                    "assets/icon/regular/check-circle.svg",
                  );
                }
              },
            ),
            BlocBuilder<DashboardBloc, DashboardState>(
              builder: (context, state) {
                if (state.isHaveProfile) {
                  return _buildSmallContainer(
                    context,
                    () {
                      Navigator.push(
                        context,
                        PageTransition(
                          curve: Curves.easeInOut,
                          type: PageTransitionType.rightToLeft,
                          child: const AddUMKMScreen(),
                          duration: const Duration(milliseconds: 150),
                          reverseDuration: const Duration(milliseconds: 150),
                        ),
                      );
                    },
                    // Text wait localization
                    AppLocalizations.of(context)!.addUmkm,
                    "assets/icon/regular/plus-square.svg",
                  );
                } else {
                  return _buildSmallContainer(
                    context,
                    () {
                      Navigator.push(
                        context,
                        PageTransition(
                          curve: Curves.easeInOut,
                          type: PageTransitionType.bottomToTop,
                          child: const RegistrationSettingScreen(),
                        ),
                      );
                    },
                    // Text wait localization
                    AppLocalizations.of(context)!.addUmkm,
                    "assets/icon/regular/plus-square.svg",
                  );
                }
              },
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
                Navigator.push(
                  context,
                  PageTransition(
                    curve: Curves.easeInOut,
                    type: PageTransitionType.bottomToTop,
                    child: const HelpScreen(),
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
                    child: const TermAndConditionScreen(),
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
              text: AppLocalizations.of(context)!.logout,
              // Must add on Tap
              onTap: () {
                _signOut();
                // final SharedPreferences prefs =
                //     await SharedPreferences.getInstance();
                // prefs.setBool('isLogIn', false);
                // final isLogin = prefs.getBool('isLogIn') ?? false;
                // print(isLogin);
                Navigator.push(
                  context,
                  PageTransition(
                    curve: Curves.easeInOut,
                    type: PageTransitionType.bottomToTop,
                    child: const LoginScreen(),
                    duration: const Duration(milliseconds: 150),
                    reverseDuration: const Duration(milliseconds: 150),
                  ),
                );
              },
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
