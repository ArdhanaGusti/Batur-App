import 'package:core/core.dart';
import 'package:flutter/material.dart';

class StatusRegisterUmkmScreen extends StatelessWidget {
  const StatusRegisterUmkmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SafeArea(
        child: Column(children: [
          const CustomAppBar(title: "Status Registrasi", hamburgerMenu: false),
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
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
                  height: 15,
                ),
                CardStatusRegistrasi(
                  img:
                      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                  title: "Teko Hias",
                  validasi: false,
                  time: "Buka (07.00 WIB -16.00 WIB)",
                  onTap: () {
                    print("Container clicked");
                  },
                ),
                SizedBox(
                  height: 15,
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
                  height: 15,
                ),
                CardStatusRegistrasi(
                  img:
                      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                  title: "Teko Hias",
                  validasi: false,
                  time: "Buka (07.00 WIB -16.00 WIB)",
                  onTap: () {
                    print("Container clicked");
                  },
                ),
                SizedBox(
                  height: 15,
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
                  height: 15,
                ),
                CardStatusRegistrasi(
                  img:
                      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                  title: "Teko Hias",
                  validasi: false,
                  time: "Buka (07.00 WIB -16.00 WIB)",
                  onTap: () {
                    print("Container clicked");
                  },
                ),
                SizedBox(
                  height: 15,
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
                  height: 15,
                ),
                CardStatusRegistrasi(
                  img:
                      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                  title: "Teko Hias",
                  validasi: false,
                  time: "Buka (07.00 WIB -16.00 WIB)",
                  onTap: () {
                    print("Container clicked");
                  },
                ),
                SizedBox(
                  height: 15,
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
                  height: 15,
                ),
                CardStatusRegistrasi(
                  img:
                      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                  title: "Teko Hias",
                  validasi: false,
                  time: "Buka (07.00 WIB -16.00 WIB)",
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
        ]),
      )),
    );
  }
}
