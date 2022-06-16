import 'package:capstone_design/presentation/components/toast/custom_alert_toast.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:theme/data/sources/theme_data.dart';

class ToastScreen extends StatefulWidget {
  const ToastScreen({Key? key}) : super(key: key);

  @override
  State<ToastScreen> createState() => _ToastScreenState();
}

class _ToastScreenState extends State<ToastScreen> {
  final toast = FToast();
  @override
  void initState() {
    super.initState();
    toast.init(context);
  }

  void toastFiled() => toast.showToast(
      child: CustomToast(
        message: "Filed",
        toastColor: bToastFiled,
        bgToastColor: bBgToastFiled,
        borderToastColor: bBorderToastFiled,
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3));

  void toastSuccess() => toast.showToast(
      child: CustomToast(
        message: "Success",
        toastColor: bToastSuccess,
        bgToastColor: bBgToastSuccess,
        borderToastColor: bBorderToastSuccess,
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3));

  void toastWarning() => toast.showToast(
      child: CustomToast(
        message: "warning",
        toastColor: bToastWarning,
        bgToastColor: bBgToastWarning,
        borderToastColor: bBorderToastWarning,
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: toastFiled,
                child: Text('Show Toast Filed'),
              ),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                onPressed: toastSuccess,
                child: Text('Show Toast Success'),
              ),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                onPressed: toastWarning,
                child: Text('Show Toast Warning'),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
