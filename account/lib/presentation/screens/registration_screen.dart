import 'package:account/account.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:theme/theme.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _regisFormKey = GlobalKey<FormState>();
  final toast = FToast();
  int bottomNavIndex = 0;

  @override
  void initState() {
    super.initState();
    toast.init(context);
    bottomNavIndex = context.read<DashboardBloc>().state.indexBottomNav;
    if (bottomNavIndex == 2 || bottomNavIndex == 3) {
      Future.microtask(() {
        context.read<DashboardBloc>().add(
              const IndexBottomNavChange(
                newIndex: 0,
              ),
            );
      });
    }
  }

  void toastError(String message) => toast.showToast(
      child: CustomToast(
        logo: "assets/icon/fill/exclamation-circle.svg",
        message: message,
        toastColor: bToastFiled,
        bgToastColor: bBgToastFiled,
        borderToastColor: bBorderToastFiled,
      ),
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 3));

  void toastSuccess(String message) => toast.showToast(
      child: CustomToast(
        logo: "assets/icon/fill/check-circle.svg",
        message: message,
        toastColor: bToastSuccess,
        bgToastColor: bBgToastSuccess,
        borderToastColor: bBorderToastSuccess,
      ),
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 3));

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 300.0 || screenSize.height < 600.0) {
      return const ErrorScreen(
        // Text wait localization
        title: "Aduh...",
        message: "Layar terlalu kecil",
      );
    } else if (screenSize.width > 500.0) {
      // Tablet Mode (Must be repair)
      return Scaffold(
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500.0),
            child: _buildRegisScreen(screenSize),
          ),
        ),
      );
    } else {
      // Mobile Mode
      return Scaffold(
        body: _buildRegisScreen(screenSize),
      );
    }
  }

  Widget _buildAppBar() {
    Brightness screenBrightness = MediaQuery.platformBrightnessOf(context);
    return SliverAppBar(
      pinned: true,
      toolbarHeight: 60.0,
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 2.0,
      titleTextStyle: bHeading4.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
      ),
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: BlocBuilder<ThemeManagerBloc, ThemeManagerState>(
          builder: (context, state) {
            bool isLight = (state.isDark == ThemeModeEnum.darkTheme)
                ? false
                : (state.isDark == ThemeModeEnum.lightTheme)
                    ? true
                    : (screenBrightness == Brightness.light)
                        ? true
                        : false;
            return Image.asset(
              (isLight) ? "assets/logo/logo.png" : "assets/logo/logo_dark.png",
              height: 40.0,
            );
          },
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(
                context,
              );
            },
            child: Center(
              child: Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icon/regular/times-square.svg",
                    color: Theme.of(context).colorScheme.tertiary,
                    height: 30.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisScreen(Size screenSize) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        _buildAppBar(),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          sliver: SliverToBoxAdapter(
            child: Text(
              // Text wait localization
              "Daftar",
              style: bHeading3.copyWith(
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          sliver: SliverToBoxAdapter(
            child: _buildForm(screenSize),
          ),
        ),
      ],
    );
  }

  Widget _buildForm(Size screenSize) {
    return BlocListener<RegisFormBloc, RegisFormState>(
      listenWhen: (previous, current) {
        if (previous.formStatus == FormStatusEnum.submittingForm) {
          return true;
        } else {
          return false;
        }
      },
      listener: (context, state) {
        if (state.formStatus == FormStatusEnum.failedSubmission) {
          toastError(state.message);
        } else if (state.formStatus == FormStatusEnum.successSubmission) {
          Future(() {
            toastSuccess(state.message);
          }).then((value) {
            context.read<DashboardBloc>().add(const IsLogInSave(value: true));
            Navigator.push(
              context,
              PageTransition(
                curve: Curves.easeInOut,
                type: PageTransitionType.rightToLeft,
                child: const RegistrationSettingScreen(),
              ),
            );
          });
        }
      },
      child: Form(
        key: _regisFormKey,
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20.0,
              ),
              child: CustomRegisEmailTextField(
                enable: true,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20.0,
              ),
              child: CustomRegisPasswordTextField(
                enable: true,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20.0,
              ),
              child: CustomRegisConfirmPasswordTextField(),
            ),
            _buildCheckBox(),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 30.0,
                top: 10.0,
              ),
              child: BlocBuilder<RegisFormBloc, RegisFormState>(
                builder: (context, state) {
                  return CustomPrimaryTextButton(
                    width: screenSize.width,
                    // Text wait localization
                    text: "Daftar",
                    onTap: () {
                      if (_regisFormKey.currentState!.validate()) {
                        if (state.password == state.passwordConf) {
                          Future(() {
                            context
                                .read<RegisFormBloc>()
                                .add(const OnEmailSignUp());
                          }).onError((error, stackTrace) {
                            toastError("Error saat Daftar");
                          });
                        } else {
                          toastError("Password Tidak Tepat");
                        }
                      } else {
                        // Text wait localization
                        toastError("Lengkapi Data Anda Terlebih Dahulu");
                      }
                    },
                  );
                },
              ),
            ),
            Text(
              // Text wait localization
              "Atau masuk menggunakan",
              style: bBody2.copyWith(
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 30.0,
              ),
              child: CustomMultipleIconButton(
                icons: const <String>[
                  "assets/icon/facebook.svg",
                  "assets/icon/google.svg",
                ],
                onTap: <Function()>[
                  () {
                    Future(() {
                      context
                          .read<RegisFormBloc>()
                          .add(const OnFacebookSignUp());
                    }).onError((er, stackTrace) {
                      // Text wait localization
                      toastError("Error saat Daftar");
                    });
                  },
                  () {
                    Future(() {
                      context.read<RegisFormBloc>().add(const OnGoogleSignUp());
                    }).onError((er, stackTrace) {
                      // Text wait localization
                      toastError("Error saat Daftar");
                    });
                  },
                ],
                width: (screenSize.width > 500.0)
                    ? (500.0 - 40.0)
                    : (screenSize.width - 40.0),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(
                  context,
                );
              },
              child: RichText(
                text: TextSpan(
                  // Text wait localization
                  text: "Sudah Punya Akun? ",
                  style: bBody2.copyWith(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      // Text wait localization
                      text: "Masuk Sekarang",
                      style: bCaption3.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 11.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckBox() {
    return BlocBuilder<RegisFormBloc, RegisFormState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: (() => context.read<LoginFormBloc>().add(
                LoginFormRememberMeChanged(
                  rememberMe: !state.rememberMe,
                ),
              )),
          child: Row(
            children: <Widget>[
              SizedBox(
                height: 24.0,
                width: 24.0,
                child: Checkbox(
                  value: state.rememberMe,
                  onChanged: (value) => context.read<RegisFormBloc>().add(
                        RegisFormRememberMeChanged(
                          rememberMe: value!,
                        ),
                      ),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Text(
                // Text wait localization
                "Ingat Saya",
                style: bBody1.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
