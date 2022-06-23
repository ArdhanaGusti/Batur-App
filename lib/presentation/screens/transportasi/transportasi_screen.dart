import 'package:capstone_design/presentation/components/card/custom_card_stasiun_list.dart';
import 'package:capstone_design/presentation/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme/theme.dart';

class TransportasiScreen extends StatelessWidget {
  const TransportasiScreen({Key? key}) : super(key: key);

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
        body: DefaultTabController(
            length: 2, // length of tabs
            initialIndex: 0,
            child: SafeArea(
              child: Column(children: <Widget>[
                const CustomAppBar(
                  title: "Transportasi",
                  hamburgerMenu: true,
                ),
                Container(
                  width: width - 100,
                  margin: EdgeInsets.only(right: 100),
                  child: TabBar(
                    indicator: BoxDecoration(
                        color: (isLight) ? bPrimary : bTextPrimary,
                        borderRadius: BorderRadius.circular(8)),
                    labelColor: (isLight) ? bTextPrimary : bTextSecondary,
                    unselectedLabelColor:
                        (isLight) ? bTextSecondary : bTextPrimary,
                    tabs: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text('Stasiun', style: bSubtitle3),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          'Terminal',
                          style: bSubtitle3,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                    child: TabBarView(children: <Widget>[
                  ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      CustomCardStasiunList(
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
                    ],
                  ),
                  ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      CustomCardStasiunList(
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
                    ],
                  ),
                ]))
              ]),
            )),
      );
    });
  }
}
