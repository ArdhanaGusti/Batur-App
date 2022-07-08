import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:theme/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Check

class GalleryScreen extends StatefulWidget {
  final List<String> images;
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
    Size screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 300.0 || screenSize.height < 600.0) {
      return ErrorScreen(
        // Text wait localization
        title: AppLocalizations.of(context)!.screenError,
        message: AppLocalizations.of(context)!.screenSmall,
      );
    } else {
      // Mobile Mode
      return Scaffold(
        body: _buildLoaded(context, screenSize),
      );
    }
  }

  Widget _buildLoaded(BuildContext context, Size screenSize) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CustomSliverAppBarTextLeading(
              // Text wait localization
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
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
                    imageProvider: NetworkImage(
                      url,
                    ),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.contained * 4.0,
                    heroAttributes: PhotoViewHeroAttributes(tag: url),
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
            SizedBox(
              height: 95.0,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                slivers: <Widget>[
                  SliverPadding(
                    padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
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
                                        ? Theme.of(context).colorScheme.tertiary
                                        : Colors.transparent,
                                    width: (index == index) ? 2.0 : 0,
                                  ),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: widget.images[index],
                                  placeholder: (context, url) {
                                    return Center(
                                      child: LoadingAnimationWidget
                                          .horizontalRotatingDots(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                        size: 10.0,
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
                                  width: 150.0,
                                  height: 80.0,
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: widget.images.length,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
