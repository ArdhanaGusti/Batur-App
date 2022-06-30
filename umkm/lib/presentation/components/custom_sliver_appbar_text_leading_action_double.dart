import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';

// Review Check 1 (Done)

class CustomSliverAppBarTextLeadingActionDouble extends StatelessWidget {
  final String title;
  final String leadingIcon;
  final Function() leadingOnTap;
  final String actionIconFirst;
  final Function() actionOnTapFirst;
  final String actionIconSecond;
  final Function() actionOnTapSecond;
  const CustomSliverAppBarTextLeadingActionDouble({
    Key? key,
    required this.title,
    required this.leadingIcon,
    required this.leadingOnTap,
    required this.actionIconFirst,
    required this.actionOnTapFirst,
    required this.actionIconSecond,
    required this.actionOnTapSecond,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      toolbarHeight: 60.0,
      backgroundColor: Theme.of(context).colorScheme.background,
      centerTitle: true,
      titleTextStyle: bHeading6.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
      ),
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      leadingWidth: 80.0,
      elevation: 2.0,
      leading: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: GestureDetector(
          onTap: leadingOnTap,
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
                  leadingIcon,
                  color: Theme.of(context).colorScheme.tertiary,
                  height: 24.0,
                ),
              ),
            ),
          ),
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: GestureDetector(
            onTap: actionOnTapFirst,
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
                    actionIconFirst,
                    color: Theme.of(context).colorScheme.tertiary,
                    height: 24.0,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: GestureDetector(
            onTap: actionOnTapSecond,
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
                    actionIconSecond,
                    color: Theme.of(context).colorScheme.tertiary,
                    height: 24.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
