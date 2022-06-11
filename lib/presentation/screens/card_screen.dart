import 'package:capstone_design/presentation/components/card/custom_card_detail_stasiun.dart';
import 'package:capstone_design/presentation/components/card/custom_card_stasiun.dart';
import 'package:capstone_design/presentation/components/card/custom_card_stasiun_list.dart';
import 'package:capstone_design/presentation/components/card/custom_card_status_registrasi.dart';
import 'package:capstone_design/presentation/components/card/custom_card_transmetro.dart';
import 'package:capstone_design/presentation/components/card/custom_card_wisata.dart';
import 'package:capstone_design/presentation/components/card/custom_detail_umkm_card.dart';
import 'package:capstone_design/presentation/components/card/custom_list_notifikasi.dart';
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
                title: "Stasiun Bandung Kota",
                description:
                    "Stasiun Bandung, juga dikenal sebagai Stasiun Hall, adalah stasiun kereta api kelas besar tipe A yang terletak di Jalan Stasiun Timur dan Jalan Kebon Kawung",
                address: "Jl. Stasiun Barat, Kb. Jeruk, Kec. Andir, Bandung",
                onTap: () {
                  print("Container clicked");
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomCardStasiunList(
                img:
                    "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                title: "Stasiun Bandung Kota",
                description:
                    "Stasiun Bandung, juga dikenal sebagai Stasiun Hall, adalah stasiun kereta api kelas besar tipe A yang terletak di Jalan Stasiun Timur dan Jalan Kebon Kawung",
                address: "Jl. Stasiun Barat, Kb. Jeruk, Kec. Andir, Bandung",
                onTap: () {
                  print("Container clicked");
                },
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
                  isFavourited: false,
                  description:
                      "Lorem ipsum It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                  onTap: () {
                    print("Container clicked");
                  }),
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
                height: 20,
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
                height: 20,
              ),
              CardWisata(
                img:
                    "https://akcdn.detik.net.id/visual/2020/03/12/2049bba1-49a2-4efb-a253-82825d9c1f2d_169.jpeg?w=650",
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
                height: 20,
              ),
              CardTransmetro(
                img:
                    "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                title: "Trans Metro Bandung",
                rute: "Cibiru – Cibeureum",
                time: "07.00 WIB -16.00 WIB",
                onTap: () {
                  print("Container clicked");
                },
              ),
              SizedBox(
                height: 20,
              ),
              CardStatusRegistrasi(
                img:
                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                title: "Teko Hias",
                validasi: true,
                time: "Buka (07.00 WIB -16.00 WIB)",
                onTap: () {
                  print("Container clicked");
                },
              ),
              SizedBox(
                height: 20,
              ),
              ListNotifikasi(
                img:
                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                title: "Kabar Bandung",
                uploadTime: "12 Menit yang lalu",
                description:
                    "Prabowo Atau Anies, Siapa Capres yang Paling Kuat?",
                onTap: () {
                  print("Container clicked");
                },
              ),
              SizedBox(
                height: 20,
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
                height: 20,
              ),
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
            ],
          ),
        ],
      ),
    );
  }
}
