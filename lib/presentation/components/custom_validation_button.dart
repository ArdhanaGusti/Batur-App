import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';

class CustomValidationButton extends StatelessWidget {
  final Color color;
  final double width;
  final bool isLight;
  final Function() onTapAcc;
  final Function() onTapDec;
  const CustomValidationButton({
    Key? key,
    required this.color,
    required this.width,
    required this.isLight,
    required this.onTapAcc,
    required this.onTapDec,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(25)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Validation",
            style: bSubtitle4.copyWith(color: bTextPrimary),
          ),
          Row(
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: onTapAcc,
                style: ButtonStyle(
                  backgroundColor: (isLight)
                      ? MaterialStateProperty.all(bAccepted)
                      : MaterialStateProperty.all(bGrey),
                  overlayColor: (isLight)
                      ? MaterialStateProperty.all(bAccepted)
                      : MaterialStateProperty.all(bGrey),
                  minimumSize: MaterialStateProperty.all(
                    const Size(
                      105,
                      25,
                    ),
                  ),
                ),
                icon: SvgPicture.asset(
                  "assets/icon/check.svg",
                  color: bTextPrimary,
                  height: 14,
                ),
                label: Text(
                  "Accepted",
                  style: bBody1.copyWith(color: bTextPrimary),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton.icon(
                onPressed: onTapDec,
                style: ButtonStyle(
                  backgroundColor: (isLight)
                      ? MaterialStateProperty.all(bError)
                      : MaterialStateProperty.all(bGrey),
                  overlayColor: (isLight)
                      ? MaterialStateProperty.all(bError)
                      : MaterialStateProperty.all(bGrey),
                  minimumSize: MaterialStateProperty.all(
                    const Size(
                      105,
                      25,
                    ),
                  ),
                ),
                icon: SvgPicture.asset(
                  "assets/icon/uncheck.svg",
                  color: bTextPrimary,
                  height: 14,
                ),
                label: Text(
                  "Rejected",
                  style: bBody1.copyWith(color: bTextPrimary),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
