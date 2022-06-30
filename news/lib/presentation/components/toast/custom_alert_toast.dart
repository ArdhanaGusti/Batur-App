import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme/theme.dart';

class CustomToast extends StatelessWidget {
  final String message;
  final Color toastColor;
  final Color bgToastColor;
  final Color borderToastColor;

  const CustomToast(
      {Key? key,
      required this.message,
      required this.toastColor,
      required this.bgToastColor,
      required this.borderToastColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeManagerBloc, ThemeManagerState>(
        builder: (context, state) {
      return Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: bgToastColor,
          border: Border.all(color: borderToastColor, width: 2.0),
          boxShadow: [
            BoxShadow(
              color: bStroke,
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4), color: toastColor),
              child: Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.white),
                child: Icon(
                  Icons.check,
                  color: toastColor,
                  size: 20,
                ),
              ),
            ),
            SizedBox(
              width: 14,
            ),
            Text(
              message,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      );
    });
  }
}
