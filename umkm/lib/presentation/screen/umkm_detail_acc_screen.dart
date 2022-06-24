import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UmkmDetailAccScreen extends StatefulWidget {
  const UmkmDetailAccScreen({Key? key}) : super(key: key);

  @override
  State<UmkmDetailAccScreen> createState() => _UmkmDetailAccScreenState();
}

class _UmkmDetailAccScreenState extends State<UmkmDetailAccScreen> {
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
      Color colorThree = (state.isDark == ThemeModeEnum.darkTheme)
          ? bGrey
          : (state.isDark == ThemeModeEnum.lightTheme)
              ? bSecondaryVariant1
              : (screenBrightness == Brightness.light)
                  ? bSecondaryVariant1
                  : bGrey;
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const CustomAppBar(title: "Detail", hamburgerMenu: false),
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    CustomDetailScreen(
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
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
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
                              offset:
                                  Offset(0, 0), // changes position of shadow
                            ),
                          ]),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Image',
                              style: bHeading7.copyWith(
                                color: (isLight) ? bPrimary : bTextPrimary,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                'https://majalahpeluang.com/wp-content/uploads/2021/03/584ukm-bandung-ayobandung.jpg',
                                width: 324,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: width,
                      margin: EdgeInsets.symmetric(horizontal: 20),
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
                              offset:
                                  Offset(0, 0), // changes position of shadow
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Senin',
                                style: bSubtitle3.copyWith(
                                  color: (isLight) ? bPrimary : bTextPrimary,
                                ),
                              ),
                              Text(
                                '07.00 - 16.00',
                                style: bSubtitle3,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Selasa',
                                style: bSubtitle3.copyWith(
                                  color: (isLight) ? bPrimary : bTextPrimary,
                                ),
                              ),
                              Text(
                                '07.00 - 16.00',
                                style: bSubtitle3,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Rabu',
                                style: bSubtitle3.copyWith(
                                  color: (isLight) ? bPrimary : bTextPrimary,
                                ),
                              ),
                              Text(
                                '07.00 - 16.00',
                                style: bSubtitle3,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'kamis',
                                style: bSubtitle3.copyWith(
                                  color: (isLight) ? bPrimary : bTextPrimary,
                                ),
                              ),
                              Text(
                                '07.00 - 16.00',
                                style: bSubtitle3,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Jumat',
                                style: bSubtitle3.copyWith(
                                  color: (isLight) ? bPrimary : bTextPrimary,
                                ),
                              ),
                              Text(
                                '07.00 - 16.00',
                                style: bSubtitle3,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sabtu',
                                style: bSubtitle3.copyWith(
                                  color: (isLight) ? bPrimary : bTextPrimary,
                                ),
                              ),
                              Text(
                                '07.00 - 16.00',
                                style: bSubtitle3,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: width,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
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
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
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
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 15.0, bottom: 30),
                            child: CustomValidationButton(
                              color: colorOne,
                              width: width,
                              onTapAcc: () {
                                // Navigator.pop(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => const Login(),
                                //   ),
                                // );
                              },
                              isLight: isLight,
                              onTapDec: () {
                                // Navigator.pop(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => const Login(),
                                //   ),
                                // );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
