import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news/news.dart';
import 'package:page_transition/page_transition.dart';
import 'package:theme/data/sources/theme_data.dart';

class NewsDetailScreenApi extends StatefulWidget {
  final String author;
  final String title;
  final String url;
  final String img;
  final String date;
  final String content;

  const NewsDetailScreenApi({
    Key? key,
    required this.author,
    required this.title,
    required this.url,
    required this.img,
    required this.date,
    required this.content,
  }) : super(key: key);

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
                Navigator.push(
                  context,
                  PageTransition(
                    curve: Curves.easeOut,
                    type: PageTransitionType.bottomToTop,
                    child: NewsWebScreen(url: widget.url),
                    duration: const Duration(milliseconds: 150),
                    reverseDuration: const Duration(milliseconds: 150),
                  ),
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
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    widget.img,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Text(
                  widget.title,
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
                          Flexible(
                            child: Text(
                              widget.author,
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
                        widget.date,
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
                  widget.content,
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
