import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:theme/theme.dart';

class CardStatusRegistrasi extends StatelessWidget {
  final String img;
  final String title;
  final bool? validasi;
  final String desc;
  final Function() onTap;
  const CardStatusRegistrasi({
    Key? key,
    required this.img,
    required this.title,
    required this.validasi,
    required this.desc,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Theme.of(context).colorScheme.secondaryContainer,
          boxShadow: const [
            BoxShadow(
              color: bStroke,
              spreadRadius: 2.0,
              blurRadius: 10.0,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: CachedNetworkImage(
                imageUrl: img,
                placeholder: (context, url) {
                  return Center(
                    child: LoadingAnimationWidget.horizontalRotatingDots(
                      color: Theme.of(context).colorScheme.tertiary,
                      size: 14.0,
                    ),
                  );
                },
                errorWidget: (context, url, error) => Center(
                  child: SvgPicture.asset(
                    "assets/icon/fill/exclamation-circle.svg",
                    color: bGrey,
                    height: 14.0,
                  ),
                ),
                fit: BoxFit.cover,
                width: 60.0,
                height: 60.0,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: bSubtitle4,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    desc,
                    style: bCaption1,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            (validasi == null)
                ? _wait(context)
                : (validasi == true)
                    ? _accept(context)
                    : _reject(context),
          ],
        ),
      ),
    );
  }

  Widget _accept(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: bAccepted,
        boxShadow: const [
          BoxShadow(
            color: bStroke,
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          SvgPicture.asset(
            "assets/icon/fill/check-circle.svg",
            color: Theme.of(context).colorScheme.tertiary,
            height: 12.0,
          ),
          const SizedBox(
            width: 3,
          ),
          Text(
            "Accepted",
            style: bCaption1,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  Widget _reject(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: bError,
        boxShadow: const [
          BoxShadow(
            color: bStroke,
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          SvgPicture.asset(
            "assets/icon/fill/exclamation-circle.svg",
            color: Theme.of(context).colorScheme.tertiary,
            height: 12.0,
          ),
          const SizedBox(
            width: 3,
          ),
          Text(
            "Rejected",
            style: bCaption1,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  Widget _wait(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: bSecondary,
        boxShadow: const [
          BoxShadow(
            color: bStroke,
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          SvgPicture.asset(
            "assets/icon/fill/question-circle.svg",
            color: Theme.of(context).colorScheme.tertiary,
            height: 12.0,
          ),
          const SizedBox(
            width: 3,
          ),
          Text(
            "Waiting",
            style: bCaption1,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
