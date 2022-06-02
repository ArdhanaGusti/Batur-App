import 'package:capstone_design/presentation/components/custom_card_stasiun.dart';
import 'package:capstone_design/presentation/components/custom_card_stasiun_list.dart';
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
              CustomCardStasiun(
                img:
                    "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                title: "Stasiun Bandung Kota",
                description:
                    "Stasiun Bandung, juga dikenal sebagai Stasiun Hall, adalah stasiun kereta api kelas besar tipe A yang terletak di Jalan Stasiun Timur dan Jalan Kebon Kawung",
                address: "Jl. Stasiun Barat, Kb. Jeruk, Kec. Andir, Bandung",
              ),
              CustomCardStasiunList(
                img:
                    "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                title: "Stasiun Bandung Kota",
                description:
                    "Stasiun Bandung, juga dikenal sebagai Stasiun Hall, adalah stasiun kereta api kelas besar tipe A yang terletak di Jalan Stasiun Timur dan Jalan Kebon Kawung",
                address: "Jl. Stasiun Barat, Kb. Jeruk, Kec. Andir, Bandung",
              ),
            ],
          )
        ],
      ),
    );
  }
}
