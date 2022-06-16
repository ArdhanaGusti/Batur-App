import 'package:capstone_design/presentation/components/card/custom_wisata_card_list.dart';
import 'package:capstone_design/presentation/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TourListScreen extends StatefulWidget {
  const TourListScreen({Key? key}) : super(key: key);

  @override
  State<TourListScreen> createState() => _TourListScreenState();
}

class _TourListScreenState extends State<TourListScreen> {
  TextEditingController nameController = TextEditingController();
  String fullName = '';
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
      return Scaffold(
        body: SafeArea(
          child: DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Column(
              children: [
                const CustomAppBar(
                    title: "Wisata dan UMKM", hamburgerMenu: true),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: [
                      Container(
                          width: width - 50,
                          margin: EdgeInsets.all(8),
                          child: TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              labelText: 'Pencarian',
                            ),
                            style: bSubtitle1.copyWith(color: bGrey),
                            onChanged: (text) {
                              setState(() {
                                fullName = text;
                              });
                            },
                          )),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: (isLight) ? bLightGrey : bDarkGrey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            "assets/icon/search.svg",
                            color: (isLight) ? bPrimary : bTextPrimary,
                            height: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Container(
                //   margin: EdgeInsets.all(20),
                //   child: Text(fullName),
                // ),
                Container(
                  width: width - 100,
                  margin: EdgeInsets.only(right: width - 250),
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
              ],
            ),
          ),
        ),
      );
    });
  }
}
