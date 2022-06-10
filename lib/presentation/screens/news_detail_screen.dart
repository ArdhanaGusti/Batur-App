import 'package:capstone_design/presentation/components/appbar/custom_sliver_appbar_text_leading.dart';
import 'package:capstone_design/presentation/components/button/custom_primary_text_button.dart';
import 'package:capstone_design/presentation/screens/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:theme/data/sources/theme_data.dart';

class NewsDetailScreen extends StatelessWidget {
  const NewsDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 320.0 || screenSize.height < 650.0) {
      return const ErrorScreen(
        // Text wait localization
        title: "Error Layar",
        message: "Aduh, Layar anda terlalu kecil",
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
        CustomSliverAppBarTextLeading(
          // Text wait localization
          title: "Berita",
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
              text: 'Lihat Berita',
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
                  child: Image.network(
                    "https://cdn-2.tstatic.net/tribunnews/foto/bank/images/indonesiatravel-gedung-sate-salah-satu-ikon-kota-bandung.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Text(
                  "Judul Disini",
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
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            // Use image assets or network
                            child: Image.asset(
                              "assets/image/profile.jpg",
                              height: 30.0,
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Flexible(
                            child: Text(
                              "Penulis",
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
