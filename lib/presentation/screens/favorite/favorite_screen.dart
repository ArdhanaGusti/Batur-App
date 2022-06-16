import 'package:capstone_design/presentation/components/card/custom_wisata_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:theme/theme.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

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
      return Scaffold(
        body: DefaultTabController(
            length: 2, // length of tabs
            initialIndex: 0,
            child: SafeArea(
              child: Column(children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  width: width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Favorite',
                        style: bHeading4.copyWith(
                          color: (isLight) ? bPrimary : bTextPrimary,
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/icon/bell-Bold.svg',
                        color: (isLight) ? bPrimary : bTextPrimary,
                        height: 25,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: width - 100,
                  margin: EdgeInsets.only(right: 100),
                  child: TabBar(
                    indicator: BoxDecoration(
                        color: (isLight) ? bPrimary : bTextPrimary,
                        borderRadius: BorderRadius.circular(8)),
                    labelColor: (isLight) ? bTextPrimary : bTextSecondary,
                    unselectedLabelColor:
                        (isLight) ? bTextSecondary : bTextPrimary,
                    tabs: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text('Wisata', style: bSubtitle3),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          'UMKM',
                          style: bSubtitle3,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                    child: TabBarView(children: <Widget>[
                  ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      CustomWisataCardList(
                        img:
                            "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                        rating: "4.5",
                        title: "Gedung Sate",
                        timeOpen: "Buka (07.00 WIB -16.00 WIB)",
                        isFavourited: true,
                        description:
                            "Lorem ipsum It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                        onTap: () {
                          print("Container clicked");
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomWisataCardList(
                        img:
                            "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                        rating: "4.5",
                        title: "Gedung Sate",
                        timeOpen: "Buka (07.00 WIB -16.00 WIB)",
                        isFavourited: false,
                        description:
                            "Lorem ipsum It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                        onTap: () {
                          print("Container clicked");
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomWisataCardList(
                        img:
                            "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                        rating: "4.5",
                        title: "Gedung Sate",
                        timeOpen: "Buka (07.00 WIB -16.00 WIB)",
                        isFavourited: false,
                        description:
                            "Lorem ipsum It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                        onTap: () {
                          print("Container clicked");
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomWisataCardList(
                        img:
                            "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                        rating: "4.5",
                        title: "Gedung Sate",
                        timeOpen: "Buka (07.00 WIB -16.00 WIB)",
                        isFavourited: true,
                        description:
                            "Lorem ipsum It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                        onTap: () {
                          print("Container clicked");
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomWisataCardList(
                        img:
                            "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                        rating: "4.5",
                        title: "Gedung Sate",
                        timeOpen: "Buka (07.00 WIB -16.00 WIB)",
                        isFavourited: false,
                        description:
                            "Lorem ipsum It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                        onTap: () {
                          print("Container clicked");
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomWisataCardList(
                        img:
                            "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                        rating: "4.5",
                        title: "Gedung Sate",
                        timeOpen: "Buka (07.00 WIB -16.00 WIB)",
                        isFavourited: false,
                        description:
                            "Lorem ipsum It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                        onTap: () {
                          print("Container clicked");
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomWisataCardList(
                        img:
                            "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                        rating: "4.5",
                        title: "Gedung Sate",
                        timeOpen: "Buka (07.00 WIB -16.00 WIB)",
                        isFavourited: true,
                        description:
                            "Lorem ipsum It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                        onTap: () {
                          print("Container clicked");
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomWisataCardList(
                        img:
                            "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                        rating: "4.5",
                        title: "Gedung Sate",
                        timeOpen: "Buka (07.00 WIB -16.00 WIB)",
                        isFavourited: false,
                        description:
                            "Lorem ipsum It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                        onTap: () {
                          print("Container clicked");
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomWisataCardList(
                        img:
                            "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                        rating: "4.5",
                        title: "Gedung Sate",
                        timeOpen: "Buka (07.00 WIB -16.00 WIB)",
                        isFavourited: false,
                        description:
                            "Lorem ipsum It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                        onTap: () {
                          print("Container clicked");
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                  ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      CustomWisataCardList(
                        img:
                            "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                        rating: "4.5",
                        title: "Teko Hias",
                        timeOpen: "Buka (07.00 WIB -16.00 WIB)",
                        isFavourited: true,
                        description:
                            "Lorem ipsum It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                        onTap: () {
                          print("Container clicked");
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomWisataCardList(
                        img:
                            "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                        rating: "4.5",
                        title: "Teko Hias",
                        timeOpen: "Buka (07.00 WIB -16.00 WIB)",
                        isFavourited: false,
                        description:
                            "Lorem ipsum It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                        onTap: () {
                          print("Container clicked");
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomWisataCardList(
                        img:
                            "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                        rating: "4.5",
                        title: "Teko Hias",
                        timeOpen: "Buka (07.00 WIB -16.00 WIB)",
                        isFavourited: false,
                        description:
                            "Lorem ipsum It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                        onTap: () {
                          print("Container clicked");
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomWisataCardList(
                        img:
                            "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                        rating: "4.5",
                        title: "Teko Hias",
                        timeOpen: "Buka (07.00 WIB -16.00 WIB)",
                        isFavourited: true,
                        description:
                            "Lorem ipsum It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                        onTap: () {
                          print("Container clicked");
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomWisataCardList(
                        img:
                            "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                        rating: "4.5",
                        title: "Teko Hias",
                        timeOpen: "Buka (07.00 WIB -16.00 WIB)",
                        isFavourited: false,
                        description:
                            "Lorem ipsum It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                        onTap: () {
                          print("Container clicked");
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomWisataCardList(
                        img:
                            "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                        rating: "4.5",
                        title: "Teko Hias",
                        timeOpen: "Buka (07.00 WIB -16.00 WIB)",
                        isFavourited: false,
                        description:
                            "Lorem ipsum It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                        onTap: () {
                          print("Container clicked");
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomWisataCardList(
                        img:
                            "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                        rating: "4.5",
                        title: "Teko Hias",
                        timeOpen: "Buka (07.00 WIB -16.00 WIB)",
                        isFavourited: true,
                        description:
                            "Lorem ipsum It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                        onTap: () {
                          print("Container clicked");
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomWisataCardList(
                        img:
                            "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                        rating: "4.5",
                        title: "Teko Hias",
                        timeOpen: "Buka (07.00 WIB -16.00 WIB)",
                        isFavourited: false,
                        description:
                            "Lorem ipsum It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                        onTap: () {
                          print("Container clicked");
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomWisataCardList(
                        img:
                            "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                        rating: "4.5",
                        title: "Teko Hias",
                        timeOpen: "Buka (07.00 WIB -16.00 WIB)",
                        isFavourited: false,
                        description:
                            "Lorem ipsum It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                        onTap: () {
                          print("Container clicked");
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ]))
              ]),
            )),
      );
    });
  }
}
