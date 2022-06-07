import 'package:capstone_design/presentation/components/card/custom_card_stasiun_list.dart';
import 'package:capstone_design/presentation/components/card/custom_wisata_card.dart';
import 'package:capstone_design/presentation/components/card/custom_wisata_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:theme/theme.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width - 60;
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
        body: SingleChildScrollView(
            child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 30),
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
                      height: 30,
                    ),
                  ],
                ),
              ),
              Container(
                width: width,
                child: Row(
                  children: [
                    Text(
                      'Wisata',
                      style: bSubtitle3.copyWith(
                          color: (isLight) ? bPrimary : bTextPrimary),
                    ),
                    SizedBox(
                      width: 60,
                    ),
                    Text('UMKM')
                  ],
                ),
              ),
              SizedBox(
                height: 20,
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
                isFavourited: false,
                description:
                    "Lorem ipsum It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                onTap: () {
                  print("Container clicked");
                },
              ),
            ],
          ),
        )),
      );
    });
  }
}
