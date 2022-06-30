import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';

class CustomToast extends StatelessWidget {
  final String message;
  final String logo;
  final Color toastColor;
  final Color bgToastColor;
  final Color borderToastColor;

  const CustomToast(
      {Key? key,
      required this.message,
      required this.logo,
      required this.toastColor,
      required this.bgToastColor,
      required this.borderToastColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: bgToastColor,
        border: Border.all(color: borderToastColor, width: 2.0),
        boxShadow: const [
          BoxShadow(
            color: bStroke,
            spreadRadius: 2.0,
            blurRadius: 10.0,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0), color: toastColor),
            child: Center(
              child: SvgPicture.asset(
                logo,
                color: bTextPrimary,
                height: 30.0,
              ),
            ),
          ),
          const SizedBox(
            width: 14.0,
          ),
          Flexible(
            child: Text(
              message,
              overflow: TextOverflow.ellipsis,
              style: bBody1.copyWith(
                color: bTextSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
