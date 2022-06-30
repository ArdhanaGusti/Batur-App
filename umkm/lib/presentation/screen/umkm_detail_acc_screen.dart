import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:umkm/presentation/bloc/umkm_remove_bloc.dart';
import 'package:umkm/presentation/bloc/umkm_state.dart';
import 'package:umkm/presentation/bloc/umkm_event.dart';
import 'package:page_transition/page_transition.dart';

class UmkmDetailAccScreen extends StatefulWidget {
  final String address, coverUrl, name, desc;
  final DocumentReference index;
  const UmkmDetailAccScreen(
      {Key? key,
      required this.address,
      required this.coverUrl,
      required this.name,
      required this.desc,
      required this.index})
      : super(key: key);

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
                      img: widget.coverUrl,
                      title: widget.name,
                      like: '155',
                      description: widget.desc,
                      address: widget.address,
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
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 15.0, bottom: 30),
                            child: BlocConsumer<UmkmRemoveBloc, UmkmState>(
                              listener: (context, state) async {
                                if (state is UmkmLoading) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: CircularProgressIndicator(),
                                  ));
                                } else if (state is UmkmRemoved) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(state.result),
                                  ));
                                } else if (state is UmkmError) {
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
                                return CustomValidationButton(
                                  color: colorOne,
                                  width: width,
                                  onTapAcc: () {
                                    context.read<UmkmRemoveBloc>().add(
                                        OnRemoveUmkm(
                                            widget.coverUrl, widget.index));
                                  },
                                  isLight: isLight,
                                  onTapDec: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        curve: Curves.easeInOut,
                                        type: PageTransitionType.rightToLeft,
                                        //ganti halaman
                                        child: UmkmDetailAccScreen(
                                          name: widget.name,
                                          coverUrl: widget.coverUrl,
                                          address: widget.address,
                                          desc: widget.desc,
                                          index: widget.index,
                                        ),
                                        duration:
                                            const Duration(milliseconds: 150),
                                        reverseDuration:
                                            const Duration(milliseconds: 150),
                                      ),
                                    );
                                  },
                                );
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
