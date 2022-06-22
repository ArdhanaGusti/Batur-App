import 'package:capstone_design/presentation/bloc/login_form_bloc.dart';
import 'package:capstone_design/presentation/components/button/custom_multiple_icon_button.dart';
import 'package:capstone_design/presentation/components/button/custom_primary_text_button.dart';
import 'package:capstone_design/presentation/components/textFields/custom_login_password_text_field.dart';
import 'package:capstone_design/presentation/components/textFields/custom_login_username_text_field.dart';
import 'package:capstone_design/presentation/screens/error_screen.dart';
import 'package:capstone_design/presentation/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:theme/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 320.0 || screenSize.height < 650.0) {
      return ErrorScreen(
        // Text wait localization
        title: AppLocalizations.of(context)!.screenError,
        message: AppLocalizations.of(context)!.screenSmall,
      );
    } else if (screenSize.width > 500.0) {
      // Tablet Mode (Must be repair)
      return SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500.0),
            child: _buildLoginScreen(screenSize),
          ),
        ),
      );
    } else {
      // Mobile Mode
      return Scaffold(
        body: SafeArea(
          child: _buildLoginScreen(screenSize),
        ),
      );
    }
  }

  Widget _buildLoginScreen(Size screenSize) {
    Brightness screenBrightness = MediaQuery.platformBrightnessOf(context);
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              BlocBuilder<ThemeManagerBloc, ThemeManagerState>(
                builder: (context, state) {
                  bool isLight = (state.isDark == ThemeModeEnum.darkTheme)
                      ? false
                      : (state.isDark == ThemeModeEnum.lightTheme)
                          ? true
                          : (screenBrightness == Brightness.light)
                              ? true
                              : false;
                  return Image.asset(
                    (isLight)
                        ? 'assets/logo/logo.png'
                        : 'assets/logo/logo_dark.png',
                    height: 40.0,
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      // Text wait localization
                      AppLocalizations.of(context)!.signIn,
                      style: bHeading3.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    _buildForm(screenSize),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildForm(Size screenSize) {
    return BlocBuilder<LoginFormBloc, LoginFormState>(
      builder: (context, state) {
        return Form(
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
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    const CustomLoginPasswordTextField(),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to Forgot Password Page
                        },
                        // Text wait localization
                        child: Text(
                          AppLocalizations.of(context)!.forgotThePassword,
                          style: bSubtitle2.copyWith(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              _buildCheckBox(state),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 30.0,
                  top: 10.0,
                ),
                child: CustomPrimaryTextButton(
                  width: screenSize.width,
                  // Text wait localization
                  text: AppLocalizations.of(context)!.signIn,
                  // On tap Navigation needs to be replaced
                  onTap: () {
                    Navigator.pop(
                      context,
                    );
                  },
                ),
              ),
              // Text wait localization
              Text(
                AppLocalizations.of(context)!.orSign,
                style: bBody2.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 30.0,
                ),
                child: CustomMultipleIconButton(
                  icons: const [
                    "assets/icon/facebook.svg",
                    "assets/icon/twitter.svg",
                    "assets/icon/google.svg",
                  ],
                  onTap: [
                    () {
                      Navigator.pop(
                        context,
                      );
                    },
                    () {
                      Navigator.pop(
                        context,
                      );
                    },
                    () {
                      Navigator.pop(
                        context,
                      );
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
                        text: AppLocalizations.of(context)!.register,
                        style: bCaption3.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 11.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCheckBox(LoginFormState state) {
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
  }
}
