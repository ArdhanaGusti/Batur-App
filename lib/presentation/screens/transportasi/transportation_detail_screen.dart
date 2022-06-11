import 'package:capstone_design/login.dart';
import 'package:capstone_design/presentation/components/card/custom_card_detail_stasiun.dart';
<<<<<<< HEAD
import 'package:capstone_design/presentation/components/custom_app_bar.dart';
import 'package:capstone_design/presentation/components/custom_text_icon_button.dart';
import 'package:flutter/material.dart';
=======
import 'package:capstone_design/presentation/components/card/custom_detail_umkm_card.dart';
import 'package:capstone_design/presentation/components/custom_app_bar.dart';
import 'package:capstone_design/presentation/components/custom_text_icon_button.dart';
import 'package:capstone_design/presentation/components/custom_validation_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
>>>>>>> c8b1995 (add tour list screen)
import 'package:theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransportationDetailScreen extends StatefulWidget {
  const TransportationDetailScreen({Key? key}) : super(key: key);

  @override
  State<TransportationDetailScreen> createState() =>
      _TransportationDetailScreenState();
}

class _TransportationDetailScreenState
    extends State<TransportationDetailScreen> {
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
<<<<<<< HEAD
          child: Column(
            children: [
              const CustomAppBar(
                  title: "Stasiun Bandung Kota", hamburgerMenu: false),
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    CustomCardDetailStasiun(
                      img:
                          'https://majalahpeluang.com/wp-content/uploads/2021/03/584ukm-bandung-ayobandung.jpg',
                      title: 'Contrary to popular belief',
                      like: '155',
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
                    Center(
                      child: Container(
                        width: width,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: (state.isDark == ThemeModeEnum.darkTheme)
                                ? bDarkGrey
                                : (state.isDark == ThemeModeEnum.lightTheme)
                                    ? bTextPrimary
                                    : (screenBrightness == Brightness.light)
                                        ? bTextPrimary
                                        : bDarkGrey,
                            boxShadow: [
                              BoxShadow(
                                color: bStroke,
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: Offset(0, 0),
                              ),
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Jadwal",
                                            style: bHeading7.copyWith(
                                                color: (isLight)
                                                    ? bPrimary
                                                    : bTextPrimary),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    "KA 105",
                                                    style: bSubtitle4.copyWith(
                                                        color: (isLight)
                                                            ? bPrimary
                                                            : bTextPrimary),
                                                  ),
                                                  Text(
                                                    "Ekonomi",
                                                    style: bCaption1.copyWith(
                                                        color: bGrey),
                                                  )
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    "Rp. 25.00",
                                                    style: bSubtitle4.copyWith(
                                                        color: (isLight)
                                                            ? bPrimary
                                                            : bTextPrimary),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    "BDG",
                                                    style: bCaption3.copyWith(
                                                        color: (isLight)
                                                            ? bPrimary
                                                            : bTextPrimary),
                                                  ),
                                                  Text(
                                                    "14.50",
                                                    style: bCaption1.copyWith(
                                                        color: bGrey),
                                                  )
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text("1 Jam 5 Menit",
                                                      style: bCaption1.copyWith(
                                                          color: bGrey)),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    "BDG",
                                                    style: bCaption3.copyWith(
                                                        color: (isLight)
                                                            ? bPrimary
                                                            : bTextPrimary),
                                                  ),
                                                  Text(
                                                    "15.55",
                                                    style: bCaption1.copyWith(
                                                        color: bGrey),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    "KA 105",
                                                    style: bSubtitle4.copyWith(
                                                        color: (isLight)
                                                            ? bPrimary
                                                            : bTextPrimary),
                                                  ),
                                                  Text(
                                                    "Ekonomi",
                                                    style: bCaption1.copyWith(
                                                        color: bGrey),
                                                  )
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    "Rp. 25.000",
                                                    style: bSubtitle4.copyWith(
                                                        color: (isLight)
                                                            ? bPrimary
                                                            : bTextPrimary),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    "BDG",
                                                    style: bCaption3.copyWith(
                                                        color: (isLight)
                                                            ? bPrimary
                                                            : bTextPrimary),
                                                  ),
                                                  Text(
                                                    "14.50",
                                                    style: bCaption1.copyWith(
                                                        color: bGrey),
                                                  )
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text("1 Jam 5 Menit",
                                                      style: bCaption1.copyWith(
                                                          color: bGrey)),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    "BDG",
                                                    style: bCaption3.copyWith(
                                                        color: (isLight)
                                                            ? bPrimary
                                                            : bTextPrimary),
                                                  ),
                                                  Text(
                                                    "15.55",
                                                    style: bCaption1.copyWith(
                                                        color: bGrey),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20),
                      child: CustomTextIconButton(
                        icon: "assets/icon/map-marker.svg",
                        color: colorTwo,
                        width: width,
                        text: "Petunjuk Arah",
                        onTap: () {
                          Navigator.pop(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
=======
          child: DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Column(
              children: [
                const CustomAppBar(
                    title: "Stasiun Bandung Kota", hamburgerMenu: false),
                Expanded(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      CustomCardDetailStasiun(
                        img:
                            'https://majalahpeluang.com/wp-content/uploads/2021/03/584ukm-bandung-ayobandung.jpg',
                        title: 'Contrary to popular belief',
                        like: '155',
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
                      Center(
                        child: Container(
                          width: width,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: (state.isDark == ThemeModeEnum.darkTheme)
                                  ? bDarkGrey
                                  : (state.isDark == ThemeModeEnum.lightTheme)
                                      ? bTextPrimary
                                      : (screenBrightness == Brightness.light)
                                          ? bTextPrimary
                                          : bDarkGrey,
                              boxShadow: [
                                BoxShadow(
                                  color: bStroke,
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: Offset(0, 0),
                                ),
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Jadwal',
                                style: bHeading7.copyWith(
                                  color: (isLight) ? bPrimary : bTextPrimary,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TabBar(
                                indicator: BoxDecoration(
                                    color: (isLight) ? bPrimary : bTextPrimary,
                                    borderRadius: BorderRadius.circular(8)),
                                labelColor:
                                    (isLight) ? bTextPrimary : bTextSecondary,
                                unselectedLabelColor:
                                    (isLight) ? bTextSecondary : bTextPrimary,
                                tabs: [
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    child: Text('Local', style: bSubtitle3),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      'All',
                                      style: bSubtitle3,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                height: 141,
                                child: TabBarView(
                                  children: [
                                    Column(
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                      "KA 105",
                                                      style: bSubtitle4.copyWith(
                                                          color: (isLight)
                                                              ? bPrimary
                                                              : bTextPrimary),
                                                    ),
                                                    Text(
                                                      "Ekonomi",
                                                      style: bCaption1.copyWith(
                                                          color: bGrey),
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      "Rp. 25.000",
                                                      style: bSubtitle4.copyWith(
                                                          color: (isLight)
                                                              ? bPrimary
                                                              : bTextPrimary),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 6,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                      "BDG",
                                                      style: bCaption3.copyWith(
                                                          color: (isLight)
                                                              ? bPrimary
                                                              : bTextPrimary),
                                                    ),
                                                    Text(
                                                      "14.50",
                                                      style: bCaption1.copyWith(
                                                          color: bGrey),
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text("1 Jam 5 Menit",
                                                        style:
                                                            bCaption1.copyWith(
                                                                color: bGrey)),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      "BDG",
                                                      style: bCaption3.copyWith(
                                                          color: (isLight)
                                                              ? bPrimary
                                                              : bTextPrimary),
                                                    ),
                                                    Text(
                                                      "15.55",
                                                      style: bCaption1.copyWith(
                                                          color: bGrey),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                      "KA 105",
                                                      style: bSubtitle4.copyWith(
                                                          color: (isLight)
                                                              ? bPrimary
                                                              : bTextPrimary),
                                                    ),
                                                    Text(
                                                      "Ekonomi",
                                                      style: bCaption1.copyWith(
                                                          color: bGrey),
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      "Rp. 25.000",
                                                      style: bSubtitle4.copyWith(
                                                          color: (isLight)
                                                              ? bPrimary
                                                              : bTextPrimary),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 6,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                      "BDG",
                                                      style: bCaption3.copyWith(
                                                          color: (isLight)
                                                              ? bPrimary
                                                              : bTextPrimary),
                                                    ),
                                                    Text(
                                                      "14.50",
                                                      style: bCaption1.copyWith(
                                                          color: bGrey),
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text("1 Jam 5 Menit",
                                                        style:
                                                            bCaption1.copyWith(
                                                                color: bGrey)),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      "BDG",
                                                      style: bCaption3.copyWith(
                                                          color: (isLight)
                                                              ? bPrimary
                                                              : bTextPrimary),
                                                    ),
                                                    Text(
                                                      "15.55",
                                                      style: bCaption1.copyWith(
                                                          color: bGrey),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [Text("data")],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20),
                        child: CustomTextIconButton(
                          icon: "assets/icon/map-marker.svg",
                          color: colorTwo,
                          width: width,
                          text: "Petunjuk Arah",
                          onTap: () {
                            Navigator.pop(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Login(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
>>>>>>> c8b1995 (add tour list screen)
          ),
        ),
      );
    });
  }
}
