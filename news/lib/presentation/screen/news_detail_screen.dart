import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:news/news.dart';
import 'package:news/presentation/screen/edit_news_screen.dart';
import 'package:theme/data/sources/theme_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:capstone_design/data/service/api_service.dart';

class NewsDetailScreen extends StatelessWidget {
  final String title, konten, urlName, writer;
  final String date;
  final DocumentReference index;
  const NewsDetailScreen(
      {Key? key,
      required this.title,
      required this.konten,
      required this.urlName,
      required this.index,
      required this.date,
      required this.writer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 320.0 || screenSize.height < 650.0) {
      return ErrorScreen(
        title: AppLocalizations.of(context)!.screenError,
        message: AppLocalizations.of(context)!.screenSmall,
      );
    } else if (screenSize.width > 500.0) {
      // Tablet Mode (Must be repair)
      return Scaffold(
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500.0),
            child: _buildNewsDetailScreen(context, screenSize),
          ),
        ),
      );
    } else {
      // Mobile Mode
      return Scaffold(
        body: _buildNewsDetailScreen(context, screenSize),
      );
    }
  }

  Widget _buildNewsDetailScreen(BuildContext context, Size screenSize) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("News").snapshots(),
            builder: (context, snapshot) {
              return CustomSliverAppBarTextLeadingAction(
                title: "Berita",
                leadingIcon: "assets/icon/bold/chevron-left.svg",
                leadingOnTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return EditNewsScreen(
                        judul: title,
                        konten: konten,
                        urlName: urlName,
                        index: index);
                  }));
                },
                actionIcon: "assets/icon/trash.svg",
                actionOnTap: () {
                  context
                      .read<NewsRemoveBloc>()
                      .add(OnRemoveNews(context, urlName, index));
                },
              );
            }),
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: CachedNetworkImage(
                    imageUrl: urlName,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Text(
                  title,
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
                          //wait profile
                          // ClipRRect(
                          //   borderRadius: BorderRadius.circular(15.0),
                          //   // Use image assets or network
                          //   child: StreamBuilder<QuerySnapshot>(
                          //       stream: FirebaseFirestore.instance
                          //           .collection('Profile')
                          //           .where('email', isEqualTo: writer)
                          //           .snapshots(),
                          //       builder: (context, snapshot) {
                          //         if (!snapshot.hasData) {
                          //           return CircularProgressIndicator();
                          //         }
                          //         return Image.network(
                          //           "${snapshot.data!.docs[0]["imgUrl"]}",
                          //           height: 30.0,
                          //         );
                          //       }),
                          // ),
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
                        DateFormat("EEEE, d MMMM yyyy", "id_ID")
                            .format(DateTime.parse(date)),
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
                  konten,
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
