import 'package:account/presentation/bloc/profile_bloc.dart';
import 'package:account/presentation/screens/edit_account_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:theme/theme.dart';
import 'package:core/core.dart';

// Review Check 1 (Done)

class AccountDetailScreen extends StatelessWidget {
  const AccountDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 320.0 || screenSize.height < 600.0) {
      return const ErrorScreen(
        // Text wait localization
        title: "AppLocalizations.of(context)!.screenError",
        message: "AppLocalizations.of(context)!.screenSmall",
      );
    } else if (screenSize.width > 500.0) {
      // Tablet Mode (Must be repair)
      return Scaffold(
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500.0),
            child: _buildAccountDetailScreen(context, screenSize),
          ),
        ),
      );
    } else {
      // Mobile Mode
      return Scaffold(
        body: _buildAccountDetailScreen(context, screenSize),
      );
    }
  }

  Widget _buildAccountDetailScreen(BuildContext context, Size screenSize) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        // Change hard code to BloC
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            // CustomSliverAppBarTextLeadingAction(
            //   // Text wait localization
            //   title: "AppLocalizations.of(context)!.accountDetail",
            //   leadingIcon: "assets/icon/regular/chevron-left.svg",
            //   leadingOnTap: () {
            //     Navigator.pop(
            //       context,
            //     );
            //   },
            //   actionIcon: "assets/icon/regular/pen.svg",
            //   actionOnTap: () {
            //     Navigator.push(
            //       context,
            //       PageTransition(
            //         curve: Curves.easeInOut,
            //         type: PageTransitionType.rightToLeft,
            //         child: const EditAccountScreen(),
            //         duration: const Duration(milliseconds: 150),
            //         reverseDuration: const Duration(milliseconds: 150),
            //       ),
            //     );
            //   },
            // ),
            SliverPadding(
              padding: const EdgeInsets.all(20.0),
              sliver: SliverToBoxAdapter(
                // Parameter use Bloc
                child: _customProfilePict(
                    "https://akcdn.detik.net.id/api/wm/2020/03/13/60cf74a7-8cc1-4a24-8f9d-0772471f9fb1_169.jpeg"),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(20.0),
              sliver: SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      _customTextContainer(
                        context,
                        // Text wait localization
                        "AppLocalizations.of(context)!.name",
                        // Parameter use Bloc
                        "Neida Aleida",
                      ),
                      _customDivider(),
                      _customTextContainer(
                        context,
                        // Text wait localization
                        "Username",
                        // Parameter use Bloc
                        "neidaaleida",
                      ),
                      _customDivider(),
                      _customTextContainer(
                        context,
                        // Text wait localization
                        "Email",
                        // Parameter use Bloc
                        "neidaaleida@gmail.com",
                      ),
                      // Display Password with Obsecure
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _customTextContainer(
    BuildContext context,
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            title,
            style: bSubtitle2.copyWith(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Flexible(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
              style: bSubtitle1.copyWith(
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _customProfilePict(String pict) {
    return Center(
      child: ClipRRect(
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
    );
  }

  Divider _customDivider() {
    return const Divider(
      height: 0,
      thickness: 1.0,
      indent: 20.0,
      endIndent: 20.0,
      color: bStroke,
    );
  }
}
