import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GalleryScreen extends StatefulWidget {
  final List<File> images;
  final int index;
  final PageController control;
  GalleryScreen({
    Key? key,
    required this.images,
    required this.index,
  })  : control = PageController(
          initialPage: index,
        ),
        super(key: key);

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  late int index = widget.index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CustomSliverAppBarTextLeading(
              title: AppLocalizations.of(context)!.imagePreview,
              leadingIcon: "assets/icon/back.svg",
              // Navigation repair
              leadingOnTap: () {
                Navigator.pop(
                  context,
                );
              },
            ),
          ];
        },
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                backgroundDecoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                ),
                pageController: widget.control,
                itemCount: widget.images.length,
                onPageChanged: (index) => setState(() {
                  this.index = index;
                }),
                allowImplicitScrolling: false,
                builder: (context, index) {
                  final url = widget.images[index];
                  return PhotoViewGalleryPageOptions(
                    imageProvider: FileImage(
                      url,
                    ),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.contained * 4,
                  );
                },
              ),
            ),
            Container(
              height: 95.0,
              padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: widget.images.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          index = index;
                        });
                        if (widget.control.hasClients) {
                          widget.control.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: (this.index == index)
                                ? Colors.white
                                : Colors.transparent,
                            width: (index == index) ? 2.0 : 0,
                          ),
                        ),
                        child: Image.file(
                          widget.images[index],
                          width: 150.0,
                          height: 80.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
