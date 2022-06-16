import 'package:capstone_design/presentation/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:theme/theme.dart';

class FilterTourListScreen extends StatefulWidget {
  const FilterTourListScreen({Key? key}) : super(key: key);

  @override
  State<FilterTourListScreen> createState() => _FilterTourListScreenState();
}

class _FilterTourListScreenState extends State<FilterTourListScreen> {
  int _value = 1;
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
            const CustomAppBar(title: "Filter", hamburgerMenu: false),
            SizedBox(
              height: 15,
            ),
            Container(
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Suka",
                    style: bSubtitle3.copyWith(
                        color: isLight ? bPrimary : bTextPrimary),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: isLight ? bPrimary : bDarkGrey),
                        child: Row(
                          children: [
                            Icon(
                              Icons.favorite,
                              color: (isLight) ? bError : bTextPrimary,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Disukai",
                              style: bSubtitle2.copyWith(color: bTextPrimary),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.check,
                              color: bTextPrimary,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          border: Border.all(
                              width: 1.0,
                              style: BorderStyle.solid,
                              color: bDarkGrey),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.favorite_border,
                              color: bGrey,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Tidak Disukai",
                              style: bSubtitle2.copyWith(color: bGrey),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Rating",
                    style: bSubtitle3.copyWith(
                        color: isLight ? bPrimary : bTextPrimary),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icon/star.svg',
                            color: (isLight) ? bSecondary : bTextPrimary,
                            height: 20,
                          ),
                          SvgPicture.asset(
                            'assets/icon/star_outline.svg',
                            color: bGrey,
                            height: 20,
                          ),
                          SvgPicture.asset(
                            'assets/icon/star_outline.svg',
                            color: bGrey,
                            height: 20,
                          ),
                          SvgPicture.asset(
                            'assets/icon/star_outline.svg',
                            color: bGrey,
                            height: 20,
                          ),
                          SvgPicture.asset(
                            'assets/icon/star_outline.svg',
                            color: bGrey,
                            height: 20,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "& up",
                            style: bBody1,
                          )
                        ],
                      ),
                      Radio(
                          value: 1,
                          groupValue: _value,
                          onChanged: (_) {
                            setState(() {
                              _value = 1;
                            });
                            print(_value);
                          })
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icon/star.svg',
                            color: (isLight) ? bSecondary : bTextPrimary,
                            height: 20,
                          ),
                          SvgPicture.asset(
                            'assets/icon/star.svg',
                            color: (isLight) ? bSecondary : bTextPrimary,
                            height: 20,
                          ),
                          SvgPicture.asset(
                            'assets/icon/star_outline.svg',
                            color: bGrey,
                            height: 20,
                          ),
                          SvgPicture.asset(
                            'assets/icon/star_outline.svg',
                            color: bGrey,
                            height: 20,
                          ),
                          SvgPicture.asset(
                            'assets/icon/star_outline.svg',
                            color: bGrey,
                            height: 20,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "& up",
                            style: bBody1,
                          )
                        ],
                      ),
                      Radio(
                          value: 2,
                          groupValue: _value,
                          onChanged: (_) {
                            setState(() {
                              _value = 2;
                            });
                            print(_value);
                          })
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icon/star.svg',
                            color: (isLight) ? bSecondary : bTextPrimary,
                            height: 20,
                          ),
                          SvgPicture.asset(
                            'assets/icon/star.svg',
                            color: (isLight) ? bSecondary : bTextPrimary,
                            height: 20,
                          ),
                          SvgPicture.asset(
                            'assets/icon/star.svg',
                            color: (isLight) ? bSecondary : bTextPrimary,
                            height: 20,
                          ),
                          SvgPicture.asset(
                            'assets/icon/star_outline.svg',
                            color: bGrey,
                            height: 20,
                          ),
                          SvgPicture.asset(
                            'assets/icon/star_outline.svg',
                            color: bGrey,
                            height: 20,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "& up",
                            style: bBody1,
                          )
                        ],
                      ),
                      Radio(
                          value: 3,
                          groupValue: _value,
                          onChanged: (_) {
                            setState(() {
                              _value = 3;
                            });
                            print(_value);
                          })
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icon/star.svg',
                            color: (isLight) ? bSecondary : bTextPrimary,
                            height: 20,
                          ),
                          SvgPicture.asset(
                            'assets/icon/star.svg',
                            color: (isLight) ? bSecondary : bTextPrimary,
                            height: 20,
                          ),
                          SvgPicture.asset(
                            'assets/icon/star.svg',
                            color: (isLight) ? bSecondary : bTextPrimary,
                            height: 20,
                          ),
                          SvgPicture.asset(
                            'assets/icon/star.svg',
                            color: (isLight) ? bSecondary : bTextPrimary,
                            height: 20,
                          ),
                          SvgPicture.asset(
                            'assets/icon/star_outline.svg',
                            color: bGrey,
                            height: 20,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "& up",
                            style: bBody1,
                          )
                        ],
                      ),
                      Radio(
                          value: 4,
                          groupValue: _value,
                          onChanged: (_) {
                            setState(() {
                              _value = 4;
                            });
                          })
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icon/star.svg',
                            color: (isLight) ? bSecondary : bTextPrimary,
                            height: 20,
                          ),
                          SvgPicture.asset(
                            'assets/icon/star.svg',
                            color: (isLight) ? bSecondary : bTextPrimary,
                            height: 20,
                          ),
                          SvgPicture.asset(
                            'assets/icon/star.svg',
                            color: (isLight) ? bSecondary : bTextPrimary,
                            height: 20,
                          ),
                          SvgPicture.asset(
                            'assets/icon/star.svg',
                            color: (isLight) ? bSecondary : bTextPrimary,
                            height: 20,
                          ),
                          SvgPicture.asset(
                            'assets/icon/star.svg',
                            color: (isLight) ? bSecondary : bTextPrimary,
                            height: 20,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "& up",
                            style: bBody1,
                          )
                        ],
                      ),
                      Radio(
                          value: 5,
                          groupValue: _value,
                          onChanged: (_) {
                            setState(() {
                              _value = 5;
                            });
                          })
                    ],
                  )
                ],
              ),
            )
          ]),
        ),
      );
    });
  }
}
