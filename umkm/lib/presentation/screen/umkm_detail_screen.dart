import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourism/presentation/components/custom_card_detail_tour_screen.dart';

import '../components/custom_sliver_appbar_text_leading_action_double.dart';

class UmkmDetailScreen extends StatefulWidget {
  const UmkmDetailScreen({Key? key}) : super(key: key);

  @override
  State<UmkmDetailScreen> createState() => _UmkmDetailScreenState();
}

class _UmkmDetailScreenState extends State<UmkmDetailScreen> {
  final List<String> carouselImages = [
    "https://thumb.viva.co.id/media/frontend/thumbs3/2022/03/23/623b099186419-red-velvet_665_374.jpg",
    "https://awsimages.detik.net.id/visual/2020/09/15/noah-15.jpeg?w=650",
    "https://media.suara.com/pictures/653x366/2022/02/09/60554-isyana-sarasvati-instagramatisyanasarasvati.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width - 40;
    return BlocBuilder<ThemeManagerBloc, ThemeManagerState>(
        builder: (context, state) {
      Brightness screenBrightness = MediaQuery.platformBrightnessOf(context);
      bool isLight = (state.isDark == ThemeModeEnum.darkTheme)
          ? false
          : (state.isDark == ThemeModeEnum.lightTheme)
              ? true
              : (screenBrightness == Brightness.light)
                  ? true
                  : false;
      Color colorOne = (state.isDark == ThemeModeEnum.darkTheme)
          ? bDarkGrey
          : (state.isDark == ThemeModeEnum.lightTheme)
              ? bPrimary
              : (screenBrightness == Brightness.light)
                  ? bPrimary
                  : bDarkGrey;
      Color colorTwo = (state.isDark == ThemeModeEnum.darkTheme)
          ? bGrey
          : (state.isDark == ThemeModeEnum.lightTheme)
              ? bPrimaryVariant1
              : (screenBrightness == Brightness.light)
                  ? bPrimaryVariant1
                  : bGrey;
      Color colorThree = (state.isDark == ThemeModeEnum.darkTheme)
          ? bGrey
          : (state.isDark == ThemeModeEnum.lightTheme)
              ? bSecondaryVariant1
              : (screenBrightness == Brightness.light)
                  ? bSecondaryVariant1
                  : bGrey;
      Color colorFour = (state.isDark == ThemeModeEnum.darkTheme)
          ? bDarkGrey
          : (state.isDark == ThemeModeEnum.lightTheme)
              ? bSecondary
              : (screenBrightness == Brightness.light)
                  ? bSecondary
                  : bDarkGrey;
      return Scaffold(
        body: SafeArea(
          child: DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Column(
              children: [
                CustomSliverAppBarTextLeadingActionDouble(
                  title: "Berita",
                  leadingIcon: "assets/icon/bold/chevron-left.svg",
                  leadingOnTap: () {
                    Navigator.pop(
                      context,
                    );
                  },
                  actionIconFirst: "assets/icon/pen-light.svg",
                  actionOnTapFirst: () {
                    // Navigator.of(context)
                    //     .push(MaterialPageRoute(builder: (context) {
                    //   return EditNewsScreen(
                    //       judul: widget.title,
                    //       konten: widget.konten,
                    //       urlName: widget.urlName,
                    //       index: widget.index);
                    // }));
                  },
                  actionIconSecond: "assets/icon/trash.svg",
                  actionOnTapSecond: () {
                    // context.read<NewsRemoveBloc>().add(
                    //     OnRemoveNews(context, widget.urlName, widget.index));
                  },
                ),
                Expanded(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      CustomCardDetailTourScreen(
                        img:
                            'https://majalahpeluang.com/wp-content/uploads/2021/03/584ukm-bandung-ayobandung.jpg',
                        title: 'Hias Teko',
                        rating: '4,5',
                        isFavourited: false,
                        carouselImages: carouselImages,
                        description:
                            'Stasiun Bandung, juga dikenal sebagai Stasiun Hall, adalah stasiun kereta api kelas besar tipe A yang terletak di Jalan Stasiun Timur dan Jalan Kebon Kawung, di Kebonjeruk, Andir, tepatnya di perbatasan antara Kelurahan Pasirkaliki, Cicendo dan Kebonjeruk, Andir, Kota Bandung, Jawa Barat.',
                        address: 'Jl. Trunojoyo No. 64 Bandung',
                        telephone: '(022) 4208757',
                        onTap: () {
                          print("Container clicked");
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: CustomTextIconButton(
                          icon: "assets/icon/shopee.svg",
                          color: colorThree,
                          width: width,
                          text: "Shopee",
                          onTap: () {
                            // Navigator.pop(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const Login(),
                            //   ),
                            // );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: CustomTextIconButton(
                          icon: "assets/icon/tokopedia.svg",
                          color: colorOne,
                          width: width,
                          text: "Tokopedia",
                          onTap: () {
                            // Navigator.pop(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const Login(),
                            //   ),
                            // );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: CustomTextIconButton(
                          icon: "assets/icon/map-marker.svg",
                          color: colorTwo,
                          width: width,
                          text: "Petunjuk Arah",
                          onTap: () {
                            // Navigator.pop(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const Login(),
                            //   ),
                            // );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
