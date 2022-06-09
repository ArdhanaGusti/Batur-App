import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';

class CustomSliverAppBarDashboard extends StatelessWidget {
  final bool isDoubleAction;
  final Widget leading;
  final String actionIcon;
  final Function() actionOnTap;
  final String actionIconSecondary;
  final Function() actionOnTapSecondary;
  const CustomSliverAppBarDashboard({
    Key? key,
    required this.isDoubleAction,
    required this.leading,
    required this.actionIcon,
    required this.actionOnTap,
    required this.actionIconSecondary,
    required this.actionOnTapSecondary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      toolbarHeight: 60.0,
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 2.0,
      titleTextStyle: bHeading4.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
      ),
      title: Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: leading,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: GestureDetector(
            onTap: actionOnTap,
            child: SvgPicture.asset(
              actionIcon,
              color: Theme.of(context).colorScheme.tertiary,
              height: 30.0,
            ),
          ),
        ),
        (isDoubleAction)
            ? GestureDetector(
                onTap: actionOnTapSecondary,
                child: SvgPicture.asset(
                  actionIconSecondary,
                  color: Theme.of(context).colorScheme.tertiary,
                  height: 30.0,
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
