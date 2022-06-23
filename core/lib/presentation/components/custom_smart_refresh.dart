import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:theme/theme.dart';

class CustomSmartRefresh extends StatelessWidget {
  final RefreshController refreshController;
  final Function() onRefresh;
  final Function() onLoading;
  final Widget child;
  const CustomSmartRefresh({
    Key? key,
    required this.refreshController,
    required this.onRefresh,
    required this.onLoading,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      onRefresh: onRefresh,
      onLoading: onLoading,
      header: ClassicHeader(
        refreshingIcon: LoadingAnimationWidget.horizontalRotatingDots(
          color: Theme.of(context).colorScheme.tertiary,
          size: 20.0,
        ),
        failedIcon: SvgPicture.asset(
          "assets/icon/fill/exclamation-circle.svg",
          color: Theme.of(context).colorScheme.tertiary,
          height: 20.0,
        ),
        completeIcon: SvgPicture.asset(
          "assets/icon/fill/check-circle.svg",
          color: Theme.of(context).colorScheme.tertiary,
          height: 20.0,
        ),
        releaseIcon: SvgPicture.asset(
          "assets/icon/fill/chevron-circle-up.svg",
          color: Theme.of(context).colorScheme.tertiary,
          height: 20.0,
        ),
        idleIcon: SvgPicture.asset(
          "assets/icon/fill/chevron-circle-down.svg",
          color: Theme.of(context).colorScheme.tertiary,
          height: 20.0,
        ),
        refreshingText: "Memperbarui...",
        releaseText: "Lepas Untuk Memperbarui...",
        idleText: "Tarik ke bawah Untuk Memperbarui...",
        failedText: "Memperbarui gagal",
        completeText: "Behasil Memperbarui",
        textStyle: bBody1.copyWith(
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
      child: child,
    );
  }
}
