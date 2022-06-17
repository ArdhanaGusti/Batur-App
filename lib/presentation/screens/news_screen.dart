import 'package:capstone_design/presentation/components/appbar/custom_sliver_appbar_dashboard.dart';
import 'package:capstone_design/presentation/screens/add_news_screen.dart';
import 'package:capstone_design/presentation/screens/error_screen.dart';
import 'package:capstone_design/presentation/screens/news_detail_screen.dart';
import 'package:capstone_design/presentation/components/card/custom_news_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

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
      return Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500.0),
          child: _buildAccountScreen(context, screenSize),
        ),
      );
    } else {
      // Mobile Mode
      return _buildAccountScreen(context, screenSize);
    }
  }

  Widget _buildAccountScreen(BuildContext context, Size screenSize) {
    Brightness screenBrightness = MediaQuery.platformBrightnessOf(context);
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        CustomSliverAppBarDashboard(
          actionIcon: "assets/icon/bell.svg",
          // Must add on Tap
          actionOnTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NewsDetailScreen(),
              ),
            );
          },
          leading: const Text(
            // Text wait localization
            "Berita",
            textAlign: TextAlign.center,
          ),
          actionIconSecondary: "assets/icon/plus-circle.svg",
          // Must add on Tap
          actionOnTapSecondary: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddNewsScreen(),
              ),
            );
          },
          // Becarefull with this
          isDoubleAction: true,
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              CustomNewsCard(
                img:
                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                title: "Prabowo Atau Anies, Siapa Capres yang Paling Kuat?",
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
                title: "Prabowo Atau Anies, Siapa Capres yang Paling Kuat?",
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
                title: "Prabowo Atau Anies, Siapa Capres yang Paling Kuat?",
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
                title: "Prabowo Atau Anies, Siapa Capres yang Paling Kuat?",
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
                title: "Prabowo Atau Anies, Siapa Capres yang Paling Kuat?",
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
                title: "Prabowo Atau Anies, Siapa Capres yang Paling Kuat?",
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
                title: "Prabowo Atau Anies, Siapa Capres yang Paling Kuat?",
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
                title: "Prabowo Atau Anies, Siapa Capres yang Paling Kuat?",
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
                title: "Prabowo Atau Anies, Siapa Capres yang Paling Kuat?",
                writer: "Udin Saparudin",
                date: "Jumat, 13 Mei 2022",
                onTap: () {
                  print("Container clicked");
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
