import 'dart:io';

import 'package:account/account.dart';
import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:theme/theme.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegistrationSettingScreen extends StatefulWidget {
  const RegistrationSettingScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationSettingScreen> createState() =>
      _RegistrationSettingScreenState();
}

class _RegistrationSettingScreenState extends State<RegistrationSettingScreen> {
  final _regisprofileFormKey = GlobalKey<FormState>();
  User user = FirebaseAuth.instance.currentUser!;
  File? image;
  String? imageName;
  final toast = FToast();

  @override
  void initState() {
    context.read<RegisFormBloc>().add(
          RegisFormEmailChanged(
            email: user.email!,
          ),
        );
    super.initState();
    toast.init(context);
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

  void pickImage() async {
    try {
      var selectedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      setState(() {
        image = File(selectedImage!.path);
        imageName = path.basename(selectedImage.path);
      });
    } on PlatformException catch (e) {
      throw UIException(e.message.toString());
    }
  }

  // void _error() {
  //   context.read<DashboardBloc>().add(const SingOut());
  //   context.read<DashboardBloc>().add(const IsLogInSave(value: false));
  //   context
  //       .read<RegisFormBloc>()
  //       .add(const RegisFormRememberMeChanged(rememberMe: false));
  // }

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
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500.0),
            child: _buildRegistrationSettingForm(context, screenSize),
          ),
        ),
      );
    } else {
      // Mobile Mode
      return Scaffold(
        body: _buildRegistrationSettingForm(context, screenSize),
      );
    }
  }

  Widget _buildRegistrationSettingForm(BuildContext context, Size screenSize) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        CustomSliverAppBarTextLeading(
          // Text wait localization
          title: AppLocalizations.of(context)!.registerProfile,
          leadingIcon: "assets/icon/regular/chevron-left.svg",
          leadingOnTap: () {
            // _error();
            Navigator.pop(
              context,
            );
          },
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          sliver: SliverToBoxAdapter(
            child: Center(
              child: (image == null)
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image.asset(
                        "assets/image/defaultProfilePict.png",
                        height: 100.0,
                        width: 100.0,
                        fit: BoxFit.cover,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image.file(
                        image!,
                        height: 100.0,
                        width: 100.0,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          sliver: SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () {
                Future(() {
                  pickImage();
                }).then((value) {
                  if (image == null) {
                    // Text wait localization
                    throw UIException(
                        AppLocalizations.of(context)!.imageNotIncluded);
                  }
                }).onError((er, stackTrace) {
                  toastError(AppLocalizations.of(context)!.imageInsertFailed);
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(
                    "assets/icon/regular/pen.svg",
                    color: Theme.of(context).colorScheme.tertiary,
                    height: 24.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      AppLocalizations.of(context)!.editProfile,
                      style: bSubtitle1.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          sliver: SliverToBoxAdapter(
            child: Form(
              key: _regisprofileFormKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: screenSize.height * 0.01,
                    ),
                    child: const CustomRegisEmailTextField(
                      enable: false,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: screenSize.height * 0.01,
                    ),
                    child: const CustomRegisUsernameTextField(),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: screenSize.height * 0.01,
                    ),
                    child: const CustomRegisFullNameTextField(),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 30.0),
          sliver: SliverToBoxAdapter(
            child: BlocConsumer<RegisFormBloc, RegisFormState>(
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
                } else if (state.formStatus ==
                    FormStatusEnum.successSubmission) {
                  toastSuccess(state.message);
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      curve: Curves.easeInOut,
                      type: PageTransitionType.topToBottom,
                      child: const DashboardScreen(),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return CustomPrimaryTextButton(
                  width: screenSize.width,
                  text: AppLocalizations.of(context)!.done,
                  onTap: () async {
                    if (_regisprofileFormKey.currentState!.validate()) {
                      if (image != null) {
                        Future(() {
                          context
                              .read<RegisFormBloc>()
                              .add(OnSignUp(image!, imageName!));
                        }).onError((error, stackTrace) {
                          toastError(
                              AppLocalizations.of(context)!.failedRegister);
                        });
                      } else {
                        toastError(
                            AppLocalizations.of(context)!.imageNotIncluded);
                      }
                    } else {
                      // Text wait localization
                      toastError(
                          AppLocalizations.of(context)!.complateYourData);
                    }
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
