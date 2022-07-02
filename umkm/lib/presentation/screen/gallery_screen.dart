import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GalleryScreen extends StatefulWidget {
  String? images;
  File? file;
  final bool typeNetwork;
  GalleryScreen({
    Key? key,
    this.images,
    this.file,
    required this.typeNetwork,
  }) : super(key: key);

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CustomSliverAppBarTextLeading(
              title: AppLocalizations.of(context)!.imagePreview,
              leadingIcon: "assets/icon/regular/chevron-left.svg",
              // Navigation repair
              leadingOnTap: () {
                Navigator.pop(
                  context,
                );
              },
            ),
          ];
        },
        body: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          backgroundDecoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
          ),
          itemCount: 1,
          allowImplicitScrolling: false,
          builder: (context, index) {
            final url = widget.images;
            return (widget.typeNetwork)
                ? PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(url!),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.contained * 4.0,
                  )
                : PhotoViewGalleryPageOptions(
                    imageProvider: FileImage(widget.file!),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.contained * 4.0,
                  );
          },
          loadingBuilder: (context, progress) {
            return Center(
              child: LoadingAnimationWidget.horizontalRotatingDots(
                color: Theme.of(context).colorScheme.tertiary,
                size: 30.0,
              ),
            );
          },
        ),
      ),
    );
  }
}
