import 'dart:io';

import 'package:account/presentation/bloc/profile_bloc.dart';
import 'package:account/utils/enum/form_enum.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:theme/theme.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Check

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({Key? key}) : super(key: key);

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  final toast = FToast();
  final _profileFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    toast.init(context);
  }

  void updateBloc(XFile? selectedImage) {
    context.read<ProfileBloc>().add(
          OnAddImage(
            File(selectedImage!.path),
            path.basename(selectedImage.path),
          ),
        );
  }

  void pickImage() async {
    var selectedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    updateBloc(selectedImage);
  }

  void toastError(String message) {
    toast.showToast(
      child: CustomToast(
        logo: "assets/icon/fill/exclamation-circle.svg",
        message: message,
        toastColor: bToastFiled,
        bgToastColor: bBgToastFiled,
        borderToastColor: bBorderToastFiled,
      ),
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 3),
    );
  }

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
      toastDuration: const Duration(seconds: 3),
    );
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
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500.0),
            child: _buildEditAccountScreen(screenSize),
          ),
        ),
      );
    } else {
      // Mobile Mode
      return Scaffold(
        body: _buildEditAccountScreen(screenSize),
      );
    }
  }

  Widget _buildEditAccountScreen(Size screenSize) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        CustomSliverAppBarTextLeading(
          // Text wait localization
          title: AppLocalizations.of(context)!.editAccount,
          leadingIcon: "assets/icon/regular/chevron-left.svg",
          leadingOnTap: () {
            Navigator.pop(
              context,
            );
          },
        ),
        SliverPadding(
          padding: const EdgeInsets.all(20.0),
          sliver: SliverToBoxAdapter(
            child: Form(
              key: _profileFormKey,
              child: Column(
                children: <Widget>[
                  _customProfilePict(
                    () {
                      pickImage();
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  _customEditForm(
                    AppLocalizations.of(context)!.fullName,
                    const CustomEditFullNameTextField(),
                  ),
                  _customEditForm(
                    AppLocalizations.of(context)!.username,
                    const CustomEditUsernameTextField(),
                  ),
                  _customEditForm(
                    AppLocalizations.of(context)!.email,
                    const CustomEditEmailTextField(),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  BlocConsumer<ProfileBloc, ProfileState>(
                    listenWhen: (previous, current) {
                      if (previous.formStatus ==
                          FormStatusEnum.submittingForm) {
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
                      }
                    },
                    builder: (context, state) {
                      return CustomPrimaryTextButton(
                        width: screenSize.width,
                        // Text wait localization
                        text: AppLocalizations.of(context)!.save,
                        onTap: () {
                          if (_profileFormKey.currentState!.validate()) {
                            context
                                .read<ProfileBloc>()
                                .add(const OnSubmitEdit());
                          } else {
                            // Text wait localization
                            toastError(
                                AppLocalizations.of(context)!.complateYourData);
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _customEditForm(String title, Widget textField) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: bHeading7.copyWith(
              color: Theme.of(context).colorScheme.tertiary,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: textField,
          ),
        ],
      ),
    );
  }

  Widget _customProfilePict(Function() onTap) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              (state.image == null)
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: CachedNetworkImage(
                        imageUrl: state.imageUrl,
                        placeholder: (context, url) {
                          return Center(
                            child:
                                LoadingAnimationWidget.horizontalRotatingDots(
                              color: Theme.of(context).colorScheme.tertiary,
                              size: 24.0,
                            ),
                          );
                        },
                        errorWidget: (context, url, error) => Center(
                          child: SvgPicture.asset(
                            "assets/icon/fill/exclamation-circle.svg",
                            color: bGrey,
                            height: 24.0,
                          ),
                        ),
                        fit: BoxFit.cover,
                        width: 100.0,
                        height: 100.0,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image.file(
                        state.image!,
                        width: 100.0,
                        height: 100.0,
                        fit: BoxFit.cover,
                      ),
                    ),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: BlocConsumer<ProfileBloc, ProfileState>(
                  listenWhen: (previous, current) {
                    if (previous.image != current.image) {
                      return true;
                    } else {
                      return false;
                    }
                  },
                  listener: (context, state) {
                    if (state.image == null || state.imageName == "") {
                      toastError(state.message);
                    } else {
                      toastSuccess(state.message);
                    }
                  },
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: onTap,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(
                            "assets/icon/regular/pen.svg",
                            color: Theme.of(context).colorScheme.tertiary,
                            height: 18.0,
                          ),
                          const SizedBox(width: 10.0),
                          Flexible(
                            child: Text(
                              // Text wait localization
                              AppLocalizations.of(context)!.editPhotoProfile,
                              overflow: TextOverflow.ellipsis,
                              style: bBody1.copyWith(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
