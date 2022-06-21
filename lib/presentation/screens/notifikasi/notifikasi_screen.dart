import 'package:capstone_design/presentation/components/card/custom_list_notifikasi.dart';
import 'package:capstone_design/presentation/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme/theme.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomAppBar(title: 'Notifikasi', hamburgerMenu: false),
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Slidable(
                      endActionPane:
                          ActionPane(motion: BehindMotion(), children: [
                        SlidableAction(
                          onPressed: ((context) {
                            //to do
                          }),
                          backgroundColor: bError,
                          icon: Icons.delete,
                        )
                      ]),
                      child: Column(
                        children: [
                          ListNotifikasi(
                            img:
                                'https://akcdn.detik.net.id/api/wm/2020/03/13/60cf74a7-8cc1-4a24-8f9d-0772471f9fb1_169.jpeg',
                            title: "Kabar Bandung",
                            uploadTime: "12 Menit yang lalu",
                            description:
                                "Prabowo Atau Anies, Siapa Capres yang Paling Kuat?",
                            onTap: () {
                              print("Container clicked");
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      height: 1,
                      color: bGrey,
                    ),
                    Slidable(
                      endActionPane:
                          ActionPane(motion: BehindMotion(), children: [
                        SlidableAction(
                          onPressed: ((context) {
                            //to do
                          }),
                          backgroundColor: bError,
                          icon: Icons.delete,
                        )
                      ]),
                      child: Column(
                        children: [
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
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      height: 1,
                      color: bGrey,
                    ),
                    Slidable(
                      endActionPane:
                          ActionPane(motion: BehindMotion(), children: [
                        SlidableAction(
                          onPressed: ((context) {
                            //to do
                          }),
                          backgroundColor: bError,
                          icon: Icons.delete,
                        )
                      ]),
                      child: Column(
                        children: [
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
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      height: 1,
                      color: bGrey,
                    ),
                    Slidable(
                      endActionPane:
                          ActionPane(motion: BehindMotion(), children: [
                        SlidableAction(
                          onPressed: ((context) {
                            //to do
                          }),
                          backgroundColor: bError,
                          icon: Icons.delete,
                        )
                      ]),
                      child: Column(
                        children: [
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
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      height: 1,
                      color: bGrey,
                    ),
                    Slidable(
                      endActionPane:
                          ActionPane(motion: BehindMotion(), children: [
                        SlidableAction(
                          onPressed: ((context) {
                            //to do
                          }),
                          backgroundColor: bError,
                          icon: Icons.delete,
                        )
                      ]),
                      child: Column(
                        children: [
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
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      height: 1,
                      color: bGrey,
                    ),
                    Slidable(
                      endActionPane:
                          ActionPane(motion: BehindMotion(), children: [
                        SlidableAction(
                          onPressed: ((context) {
                            //to do
                          }),
                          backgroundColor: bError,
                          icon: Icons.delete,
                        )
                      ]),
                      child: Column(
                        children: [
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
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      height: 1,
                      color: bGrey,
                    ),
                    Slidable(
                      endActionPane:
                          ActionPane(motion: BehindMotion(), children: [
                        SlidableAction(
                          onPressed: ((context) {
                            //to do
                          }),
                          backgroundColor: bError,
                          icon: Icons.delete,
                        )
                      ]),
                      child: Column(
                        children: [
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
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      height: 1,
                      color: bGrey,
                    ),
                    Slidable(
                      endActionPane:
                          ActionPane(motion: BehindMotion(), children: [
                        SlidableAction(
                          onPressed: ((context) {
                            //to do
                          }),
                          backgroundColor: bError,
                          icon: Icons.delete,
                        )
                      ]),
                      child: Column(
                        children: [
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
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      height: 1,
                      color: bGrey,
                    ),
                    Slidable(
                      endActionPane:
                          ActionPane(motion: BehindMotion(), children: [
                        SlidableAction(
                          onPressed: ((context) {
                            //to do
                          }),
                          backgroundColor: bError,
                          icon: Icons.delete,
                        )
                      ]),
                      child: Column(
                        children: [
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
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      height: 1,
                      color: bGrey,
                    ),
                    Slidable(
                      endActionPane:
                          ActionPane(motion: BehindMotion(), children: [
                        SlidableAction(
                          onPressed: ((context) {
                            //to do
                          }),
                          backgroundColor: bError,
                          icon: Icons.delete,
                        )
                      ]),
                      child: Column(
                        children: [
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
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      height: 1,
                      color: bGrey,
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
