import 'package:cached_network_image/cached_network_image.dart';
import 'package:capstone_design/presentation/components/appbar/custom_sliver_appbar_text_leading.dart';
import 'package:capstone_design/presentation/components/button/custom_primary_text_button.dart';
import 'package:capstone_design/presentation/components/button/custom_secondary_icon_text_button.dart';
import 'package:capstone_design/presentation/components/textFields/custom_edit_email_text_field.dart';
import 'package:capstone_design/presentation/components/textFields/custom_edit_full_name_text_field.dart';
import 'package:capstone_design/presentation/components/textFields/custom_edit_username_text_field.dart';
import 'package:capstone_design/presentation/screens/error_screen.dart';
import 'package:capstone_design/presentation/screens/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:theme/theme.dart';

// Review Check 1 (Done)

class EditAccountScreen extends StatelessWidget {
  const EditAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 320.0 || screenSize.height < 600.0) {
      return const ErrorScreen(
        // Text wait localization
        title: "Error Layar",
        message: "Aduh, Layar anda terlalu kecil",
      );
    } else if (screenSize.width > 500.0) {
      // Tablet Mode (Must be repair)
      return Scaffold(
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500.0),
            child: _buildEditAccountScreen(context, screenSize),
          ),
        ),
      );
    } else {
      // Mobile Mode
      return Scaffold(
        body: _buildEditAccountScreen(context, screenSize),
      );
    }
  }

  Widget _buildEditAccountScreen(BuildContext context, Size screenSize) {
    // Use Bloc
    // Use Form Widget
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        CustomSliverAppBarTextLeading(
          // Text wait localization
          title: "Edit Akun",
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
            // Parameter image use Bloc
            child: _customProfilePict(
              context,
              "https://akcdn.detik.net.id/api/wm/2020/03/13/60cf74a7-8cc1-4a24-8f9d-0772471f9fb1_169.jpeg",
              () {},
            ),
          ),
        ),
        _customEditForm(
          context,
          // Text wait localization
          "Nama Lengkap",
          const CustomEditFullNameTextField(),
        ),
        _customEditForm(
          context,
          // Text wait localization
          "Username",
          const CustomEditUsernameTextField(),
        ),
        _customEditForm(
          context,
          // Text wait localization
          "Email",
          const CustomEditEmailTextField(),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(
            top: 30.0,
            left: 20.0,
            right: 20.0,
          ),
          sliver: SliverToBoxAdapter(
            child: CustomSecondaryIconTextButton(
              width: screenSize.width,
              // Text wait localization
              text: 'Ganti Password',
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    curve: Curves.easeInOut,
                    type: PageTransitionType.bottomToTop,
                    child: const ResetPasswordScreen(),
                    duration: const Duration(milliseconds: 150),
                    reverseDuration: const Duration(milliseconds: 150),
                  ),
                );
              },
              icon: "assets/icon/bold/lock.svg",
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(
            top: 20.0,
            left: 20.0,
            right: 20.0,
            bottom: 30.0,
          ),
          sliver: SliverToBoxAdapter(
            child: CustomPrimaryTextButton(
              width: screenSize.width,
              // Text wait localization
              text: 'Simpan',
              // On tap Navigation needs to be replaced
              onTap: () {
                Navigator.pop(
                  context,
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _customEditForm(
    BuildContext context,
    String title,
    Widget textField,
  ) {
    return SliverPadding(
      padding: const EdgeInsets.only(
        top: 20.0,
        left: 20.0,
        right: 20.0,
      ),
      sliver: SliverToBoxAdapter(
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
      ),
    );
  }

  Widget _customProfilePict(
    BuildContext context,
    String pict,
    Function() onTap,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            // Image must repair, still error if invalid URL
            child: CachedNetworkImage(
              imageUrl: pict,
              placeholder: (context, url) {
                return Center(
                  child: LoadingAnimationWidget.horizontalRotatingDots(
                    color: Theme.of(context).colorScheme.tertiary,
                    size: 10.0,
                  ),
                );
              },
              errorWidget: (context, url, error) => SvgPicture.asset(
                "assets/icon/fill/exclamation-circle.svg",
                color: bGrey,
                height: 14.0,
              ),
              fit: BoxFit.cover,
              width: 100.0,
              height: 100.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: GestureDetector(
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
                      "Edit Photo Profile",
                      overflow: TextOverflow.ellipsis,
                      style: bBody1.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
