import 'package:capstone_design/presentation/components/card/custom_card_stasiun.dart';
import 'package:capstone_design/presentation/components/card/custom_card_stasiun_list.dart';
import 'package:capstone_design/presentation/components/card/custom_news_card.dart';
import 'package:capstone_design/presentation/components/card/custom_wisata_card.dart';
import 'package:capstone_design/presentation/components/card/custom_wisata_card_list.dart';
import 'package:flutter/material.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: 30,
              ),
              CustomCardStasiun(
                img:
                    "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                title: "Stasiun Bandung Kota a",
                description:
                    "Stasiun Bandung, juga dikenal sebagai Stasiun Hall, adalah stasiun kereta api kelas besar tipe A yang terletak di Jalan Stasiun Timur dan Jalan Kebon Kawung",
                address: "Jl. Stasiun Barat, Kb. Jeruk, Kec. Andir, Bandung",
              ),
              SizedBox(
                height: 20,
              ),
              CustomCardStasiunList(
                img:
                    "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                title: "Stasiun Bandung Kota dua tiga empat lima",
                description:
                    "Stasiun Bandung, juga dikenal sebagai Stasiun Hall, adalah stasiun kereta api kelas besar tipe A yang terletak di Jalan Stasiun Timur dan Jalan Kebon Kawung",
                address:
                    "Jl. Stasiun Barat, Kb. Jeruk, Kec. Andir, Bandung satu dua tiga",
              ),
              SizedBox(
                height: 20,
              ),
              CustomWisataCard(
                  img:
                      "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                  rating: "4.5",
                  title: "Gedung Sate",
                  timeOpen: "Buka (07.00 WIB -16.00 WIB)",
                  description:
                      "Lorem ipsum It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout."),
              CustomWisataCardList(
                  img:
                      "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                  rating: "4.5",
                  title: "Gedung Sate",
                  timeOpen: "Buka (07.00 WIB -16.00 WIB)",
                  isFavourited: false,
                  onTap: () {},
                  description:
                      "Lorem ipsum It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout."),
              CustomNewsCard(
                  img:
                      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                  title: "Prabowo Atau Anies, Siapa Capres yang Paling Kuat?",
                  writer: "Udin Saparudin",
                  date: "Jumat, 13 Mei 2022")
            ],
          ),
        ],
      ),
    );
  }
}