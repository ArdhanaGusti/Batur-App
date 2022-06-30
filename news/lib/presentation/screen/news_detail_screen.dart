import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:news/news.dart';
import 'package:news/presentation/components/custom_sliver_appbar_text_leading_action_double.dart';
import 'package:news/presentation/screen/edit_news_screen.dart';
import 'package:theme/data/sources/theme_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:capstone_design/data/service/api_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class NewsDetailScreen extends StatefulWidget {
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
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  final toast = FToast();
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
              return BlocConsumer<NewsRemoveBloc, NewsState>(
                listener: (context, state) async {
                  if (state is NewsLoading) {
                    Center(
                      child: LoadingAnimationWidget.horizontalRotatingDots(
                        color: Theme.of(context).colorScheme.tertiary,
                        size: 50.0,
                      ),
                    );
                  } else if (state is NewsRemoved) {
                    print("sudah dihapus");
                    toast.showToast(
                        child: CustomToast(
                          message: state.result,
                          toastColor: bToastSuccess,
                          bgToastColor: bBgToastSuccess,
                          borderToastColor: bBorderToastSuccess,
                        ),
                        gravity: ToastGravity.BOTTOM,
                        toastDuration: Duration(seconds: 3));
                  } else if (state is NewsError) {
                    await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text(state.message),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Kembali"),
                              )
                            ],
                          );
                        });
                  }
                },
                builder: (context, state) {
                  return CustomSliverAppBarTextLeadingActionDouble(
                    title: "Berita",
                    leadingIcon: "assets/icon/bold/chevron-left.svg",
                    leadingOnTap: () {
                      Navigator.pop(
                        context,
                      );
                    },
                    actionIconFirst: "assets/icon/pen-light.svg",
                    actionOnTapFirst: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return EditNewsScreen(
                            judul: widget.title,
                            konten: widget.konten,
                            urlName: widget.urlName,
                            index: widget.index);
                      }));
                    },
                    actionIconSecond: "assets/icon/trash.svg",
                    actionOnTapSecond: () {
                      context.read<NewsRemoveBloc>().add(
                          OnRemoveNews(context, widget.urlName, widget.index));
                    },
                  );
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
                    imageUrl: widget.urlName,
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
                            .format(DateTime.parse(widget.date)),
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
                  widget.konten,
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
