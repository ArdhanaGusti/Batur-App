import 'package:account/account.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:theme/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Check (Done)

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final toast = FToast();
  int bottomNavIndex = 0;

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

  void toastSuccess(String message) {
    toast.showToast(
        child: CustomToast(
          logo: "assets/icon/fill/check-circle.svg",
          message: message,
          toastColor: bToastSuccess,
          bgToastColor: bBgToastSuccess,
          borderToastColor: bBorderToastSuccess,
        ),
        gravity: ToastGravity.TOP,
        toastDuration: const Duration(seconds: 3));
  }

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

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 300.0 || screenSize.height < 600.0) {
      return ErrorScreen(
        // Text wait localization
        title: AppLocalizations.of(context)!.oops,
        message: AppLocalizations.of(context)!.screenSmall,
      );
    } else if (screenSize.width > 500.0) {
      // Tablet Mode (Must be repair)
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500.0),
              child: _buildLoginScreen(screenSize),
            ),
          ),
        ),
      );
    } else {
      // Mobile Mode
      return Scaffold(
        body: _buildLoginScreen(screenSize),
      );
    }
  }

  Widget _buildAppBar(Size screenSize) {
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
              height: screenSize.height * 0.05,
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

  Widget _buildLoginScreen(Size screenSize) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        _buildAppBar(screenSize),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          sliver: SliverToBoxAdapter(
            child: Text(
              // Text wait localization
              AppLocalizations.of(context)!.logIn,
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
    return BlocListener<LoginFormBloc, LoginFormState>(
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const DashboardScreen(),
              ),
            );
          });
        }
      },
      child: Form(
        key: _loginFormKey,
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20.0,
              ),
              child: CustomLoginUsernameTextField(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 20.0,
                top: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  const CustomLoginPasswordTextField(),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          PageTransition(
                            curve: Curves.easeInOut,
                            type: PageTransitionType.bottomToTop,
                            child: const ForgotPasswordScreen(),
                            duration: const Duration(milliseconds: 150),
                            reverseDuration: const Duration(milliseconds: 150),
                          ),
                        );
                      },
                      // Text wait localization
                      child: Text(
                        AppLocalizations.of(context)!.forgotThePassword,
                        style: bSubtitle2.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _buildCheckBox(),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 30.0,
                top: 10.0,
              ),
              child: CustomPrimaryTextButton(
                width: screenSize.width,
                // Text wait localization
                text: AppLocalizations.of(context)!.logIn,
                onTap: () {
                  if (_loginFormKey.currentState!.validate()) {
                    context.read<LoginFormBloc>().add(const OnEmailSignIn());
                    print("object");
                    // });
                  } else {
                    // Text wait localization
                    toastError(AppLocalizations.of(context)!.complateYourData);
                  }
                },
              ),
            ),
            // Text wait localization
            Text(
              AppLocalizations.of(context)!.orlogIn,
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
                          .read<LoginFormBloc>()
                          .add(const OnFacebookSignIn());
                    }).onError((error, stackTrace) {
                      // Text wait localization
                      toastError(AppLocalizations.of(context)!.errorLogin);
                    });
                  },
                  () {
                    Future(() {
                      context.read<LoginFormBloc>().add(const OnGoogleSignIn());
                    }).onError((error, stackTrace) {
                      // Text wait localization
                      toastError(AppLocalizations.of(context)!.errorLogin);
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
                Navigator.push(
                  context,
                  PageTransition(
                    curve: Curves.easeInOut,
                    type: PageTransitionType.rightToLeftJoined,
                    childCurrent: widget,
                    child: const RegistrationScreen(),
                  ),
                );
              },
              child: RichText(
                // Text wait localization
                text: TextSpan(
                  text: AppLocalizations.of(context)!.dontHaveAccount,
                  style: bBody2.copyWith(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  children: <TextSpan>[
                    // Text wait localization
                    TextSpan(
                      text: AppLocalizations.of(context)!.registerNow,
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
    return BlocBuilder<LoginFormBloc, LoginFormState>(
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
                  onChanged: (value) => context.read<LoginFormBloc>().add(
                        LoginFormRememberMeChanged(
                          rememberMe: value!,
                        ),
                      ),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              // Text wait localization
              Text(
                AppLocalizations.of(context)!.rememberMe,
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
