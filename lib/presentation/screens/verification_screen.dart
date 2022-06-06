import 'package:capstone_design/presentation/bloc/verification_form_bloc.dart';
import 'package:capstone_design/presentation/components/appbar/custom_appbar.dart';
import 'package:capstone_design/presentation/components/button/custom_primary_text_button.dart';
import 'package:capstone_design/presentation/components/textFields/custom_verification_text_field.dart';
import 'package:capstone_design/presentation/screens/dashboard_screen.dart';
import 'package:capstone_design/presentation/screens/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme/theme.dart';

class VerificationScreen extends StatelessWidget {
  VerificationScreen({Key? key}) : super(key: key);
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  final focus4 = FocusNode();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 320.0 || screenSize.height < 650.0) {
      return const ErrorScreen(
        // Text wait localization
        title: "Error Layar",
        message: "Aduh, Layar anda terlalu kecil",
      );
    } else if (screenSize.width > 500.0) {
      // Tablet Mode (Must be repair)
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500.0),
              child: _buildVerificationScreen(context, screenSize),
            ),
          ),
        ),
      );
    } else {
      // Mobile Mode
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: _buildVerificationScreen(context, screenSize),
        ),
      );
    }
  }

  Widget _buildVerificationScreen(BuildContext context, Size screenSize) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              CustomAppBarLeadingBack(
                onTap: () {
                  Navigator.pop(
                    context,
                  );
                },
                // Text wait localization
                title: "Verifikasi",
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: screenSize.height * 0.05,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icon/envelope-fill.svg",
                    color: Theme.of(context).colorScheme.tertiary,
                    height: 100.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: screenSize.height * 0.05,
                ),
                child: Center(
                  // Text wait localization
                  child: Text(
                    'Kode verifikasi telah dikirim ke Email anda Masukkan kode verifikasi di sini',
                    style: bSubtitle1.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: screenSize.height * 0.05,
                ),
                child: Center(
                  child: Form(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomVerificationTextField(
                          focusNow: focus1,
                          focusNext: focus2,
                          field: 1,
                        ),
                        CustomVerificationTextField(
                          focusNow: focus2,
                          focusNext: focus3,
                          field: 2,
                        ),
                        CustomVerificationTextField(
                          focusNow: focus3,
                          focusNext: focus4,
                          field: 3,
                        ),
                        CustomVerificationTextField(
                          focusNow: focus4,
                          focusNext: focus4,
                          field: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenSize.height * 0.02),
                child: Center(
                  // Text wait localization
                  child: Text(
                    'Tidak menerima kode verifikasi?',
                    style: bSubtitle1.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenSize.height * 0.01),
                child: Center(
                  child: GestureDetector(
                    // On tap must be replace
                    onTap: () {},
                    // Text wait localization
                    child: Text(
                      'Kirim Kembali Kode Verifikasi',
                      style: bSubtitle3.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
          CustomPrimaryTextButton(
            width: screenSize.width,
            // Text wait localization
            text: 'Verifikasi',
            onTap: () {
              // On tap must be replace
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const DashboardScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
