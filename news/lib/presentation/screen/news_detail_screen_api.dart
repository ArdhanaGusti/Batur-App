import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:theme/data/sources/theme_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewsDetailScreenApi extends StatefulWidget {
  const NewsDetailScreenApi({Key? key}) : super(key: key);

  @override
  State<NewsDetailScreenApi> createState() => _NewsDetailScreenApiState();
}

class _NewsDetailScreenApiState extends State<NewsDetailScreenApi> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 320.0 || screenSize.height < 650.0) {
      return ErrorScreen(
        // Text wait localization
        title: AppLocalizations.of(context)!.screenError,
        message: AppLocalizations.of(context)!.screenSmall,
      );
    } else if (screenSize.width > 500.0) {
      // Tablet Mode (Must be repair)
      return Scaffold(
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500.0),
            child: _buildNewsDetailScreenApi(context, screenSize),
          ),
        ),
      );
    } else {
      // Mobile Mode
      return Scaffold(
        body: _buildNewsDetailScreenApi(context, screenSize),
      );
    }
  }

  Widget _buildNewsDetailScreenApi(BuildContext context, Size screenSize) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        CustomSliverAppBarTextLeading(
          // Text wait localization
          title: AppLocalizations.of(context)!.news,
          leadingIcon: "assets/icon/back.svg",
          // Navigation repair
          leadingOnTap: () {
            Navigator.pop(
              context,
            );
          },
        ),
        _customContainerNewsDetail(context, screenSize),
        SliverPadding(
          padding: const EdgeInsets.only(
            bottom: 20.0,
            top: 10.0,
            left: 20.0,
            right: 20.0,
          ),
          sliver: SliverToBoxAdapter(
            child: CustomPrimaryTextButton(
              width: screenSize.width,
              // Text wait localization
              text: AppLocalizations.of(context)!.viewNews,
              // On tap Navigation needs to be replaced
              onTap: () {
                Navigator.pop(
                  context,
                );
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _customContainerNewsDetail(BuildContext context, Size screenSize) {
    return SliverPadding(
      padding: const EdgeInsets.all(
        20.0,
      ),
      sliver: SliverToBoxAdapter(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://cdn-2.tstatic.net/tribunnews/foto/bank/images/indonesiatravel-gedung-sate-salah-satu-ikon-kota-bandung.jpg",
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
                      width: 85.0,
                      height: 85.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Text(
                  AppLocalizations.of(context)!.titleHere,
                  style: bHeading7.copyWith(
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                "assets/image/profile.jpg",
                                scale: 1.0),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Flexible(
                            child: Text(
                              AppLocalizations.of(context)!.writer,
                              overflow: TextOverflow.ellipsis,
                              style: bBody1.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiaryContainer,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Jumat, 31, Mei 2022",
                        overflow: TextOverflow.ellipsis,
                        style: bCaption1.copyWith(
                          color:
                              Theme.of(context).colorScheme.tertiaryContainer,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  '''Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web and a sites still in their infancy. Various versions have evolved over than to do the years, sometimes by accident, sometimes on off the purpose (injected humour and the like).It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. 

The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as oppo.

It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to. 

Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.''',
                  style: bSubtitle2.copyWith(
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
