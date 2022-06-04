import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';

class CustomMultipleIconButton extends StatelessWidget {
  final List<String> icons;
  final List<Function()> onTap;
  final double width;
  const CustomMultipleIconButton({
    Key? key,
    required this.icons,
    required this.onTap,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 50.0,
      child: Center(
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 30.0 / (icons.length - 1),
            );
          },
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: icons.length,
          itemBuilder: (context, index) {
            final icon = icons[index];
            final tap = onTap[index];

            return BlocBuilder<ThemeManagerBloc, ThemeManagerState>(
              builder: (context, state) {
                Brightness screenBrightness =
                    MediaQuery.platformBrightnessOf(context);
                bool isLight = (state.isDark == ThemeModeEnum.darkTheme)
                    ? false
                    : (state.isDark == ThemeModeEnum.lightTheme)
                        ? true
                        : (screenBrightness == Brightness.light)
                            ? true
                            : false;
                return Center(
                  child: SizedBox(
                    width: (icons.length == 1)
                        ? width
                        : (width - 30.0) / icons.length,
                    child: ElevatedButton(
                      onPressed: tap,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.secondaryContainer,
                        ),
                        overlayColor: (isLight)
                            ? MaterialStateProperty.all(bLightGrey)
                            : MaterialStateProperty.all(bGrey),
                        minimumSize: MaterialStateProperty.all(
                          Size(
                            width / 3,
                            50.0,
                          ),
                        ),
                        maximumSize: MaterialStateProperty.all(
                          Size(
                            width / 3,
                            50.0,
                          ),
                        ),
                      ),
                      child: (isLight)
                          ? SvgPicture.asset(
                              icon,
                              height: 24.0,
                            )
                          : SvgPicture.asset(
                              icon,
                              color: bTextPrimary,
                              height: 24.0,
                            ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
