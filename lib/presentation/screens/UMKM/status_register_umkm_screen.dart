import 'package:capstone_design/presentation/components/card/custom_card_status_registrasi.dart';
import 'package:capstone_design/presentation/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
<<<<<<< HEAD
=======
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
>>>>>>> ab30d61 (add status register umkm screen)
=======
>>>>>>> 3b0a7ce (add filter tour list screen)

class StatusRegisterUmkmScreen extends StatelessWidget {
  const StatusRegisterUmkmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
<<<<<<< HEAD
<<<<<<< HEAD
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
=======
          child: Center(
        child: Column(children: [
          const CustomAppBar(title: "Status Registrasi", hamburgerMenu: false),
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
>>>>>>> ab30d61 (add status register umkm screen)
=======
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
>>>>>>> a2577e4 (revisi card and screen)
          ),
        ]),
      )),
    );
  }
}
