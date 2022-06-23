import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme/theme.dart';

class MapTransportasiScreen extends StatelessWidget {
  const MapTransportasiScreen({Key? key}) : super(key: key);

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
          child: Column(children: <Widget>[
            const CustomAppBar(
              title: "Transportasi",
              hamburgerMenu: true,
            ),
            Expanded(
              child: ListView(
                children: [
                  Stack(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/splashscreen/map.jpg',
                            fit: BoxFit.cover,
                            height: screenSize.height - 125,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 35,
                                right: 35,
                                top: screenSize.height - 145 - 100),
                            child: CustomCardStasiun(
                              img:
                                  "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                              title: "Stasiun Bandung Kota",
                              description:
                                  "Stasiun Bandung, juga dikenal sebagai Stasiun Hall, adalah stasiun kereta api kelas besar tipe A yang terletak di Jalan Stasiun Timur dan Jalan Kebon Kawung",
                              address:
                                  "Jl. Stasiun Barat, Kb. Jeruk, Kec. Andir, Bandung",
                              onTap: () {
                                print("Container clicked");
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )
          ]),
        ),
      );
    });
  }
}
