import 'package:capstone_design/presentation/components/card/custom_news_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:theme/theme.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

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
        body: SafeArea(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Berita',
                      style: bHeading4.copyWith(
                        color: (isLight) ? bPrimary : bTextPrimary,
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icon/bell.svg',
                          color: (isLight) ? bPrimary : bTextPrimary,
                          height: 25,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset(
                          'assets/icon/bell-Bold.svg',
                          color: (isLight) ? bPrimary : bTextPrimary,
                          height: 25,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    CustomNewsCard(
                      img:
                          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                      title:
                          "Prabowo Atau Anies, Siapa Capres yang Paling Kuat?",
                      writer: "Udin Saparudin",
                      date: "Jumat, 13 Mei 2022",
                      onTap: () {
                        print("Container clicked");
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomNewsCard(
                      img:
                          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                      title:
                          "Prabowo Atau Anies, Siapa Capres yang Paling Kuat?",
                      writer: "Udin Saparudin",
                      date: "Jumat, 13 Mei 2022",
                      onTap: () {
                        print("Container clicked");
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomNewsCard(
                      img:
                          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                      title:
                          "Prabowo Atau Anies, Siapa Capres yang Paling Kuat?",
                      writer: "Udin Saparudin",
                      date: "Jumat, 13 Mei 2022",
                      onTap: () {
                        print("Container clicked");
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomNewsCard(
                      img:
                          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                      title:
                          "Prabowo Atau Anies, Siapa Capres yang Paling Kuat?",
                      writer: "Udin Saparudin",
                      date: "Jumat, 13 Mei 2022",
                      onTap: () {
                        print("Container clicked");
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomNewsCard(
                      img:
                          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                      title:
                          "Prabowo Atau Anies, Siapa Capres yang Paling Kuat?",
                      writer: "Udin Saparudin",
                      date: "Jumat, 13 Mei 2022",
                      onTap: () {
                        print("Container clicked");
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomNewsCard(
                      img:
                          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                      title:
                          "Prabowo Atau Anies, Siapa Capres yang Paling Kuat?",
                      writer: "Udin Saparudin",
                      date: "Jumat, 13 Mei 2022",
                      onTap: () {
                        print("Container clicked");
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomNewsCard(
                      img:
                          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                      title:
                          "Prabowo Atau Anies, Siapa Capres yang Paling Kuat?",
                      writer: "Udin Saparudin",
                      date: "Jumat, 13 Mei 2022",
                      onTap: () {
                        print("Container clicked");
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomNewsCard(
                      img:
                          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                      title:
                          "Prabowo Atau Anies, Siapa Capres yang Paling Kuat?",
                      writer: "Udin Saparudin",
                      date: "Jumat, 13 Mei 2022",
                      onTap: () {
                        print("Container clicked");
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomNewsCard(
                      img:
                          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                      title:
                          "Prabowo Atau Anies, Siapa Capres yang Paling Kuat?",
                      writer: "Udin Saparudin",
                      date: "Jumat, 13 Mei 2022",
                      onTap: () {
                        print("Container clicked");
                      },
                    ),
                    SizedBox(
                      height: 15,
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
