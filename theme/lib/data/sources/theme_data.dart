import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// colors
const Color bPrimary = Color(0xFF1F3C88);
const Color bPrimaryVariant1 = Color(0xFF070D59);
const Color bPrimaryVariant2 = Color(0xFF5893D4);
const Color bSecondary = Color(0xFFF7B633);
const Color bSecondaryVariant1 = Color(0xFFE4A015);
const Color bTextPrimary = Color(0xFFFFFFFF);
const Color bTextSecondary = Color(0xFF000000);
const Color bError = Color(0xFFB00020);
const Color bAccepted = Color(0xFF3CAE5C);
const Color bBackgroundPrimary = Color(0xFFF9FAFF);
const Color bBackgroundSecondary = Color(0xFF1B222A);
const Color bGrey = Color(0xFF5C5C5C);
const Color bDarkGrey = Color(0xFF33393F);
const Color bLightGrey = Color(0xFFEEEEF0);
const Color bStroke = Color.fromARGB(30, 0, 0, 0);

// border
OutlineInputBorder bBorderBuilder(Color color) {
  return OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(28)),
    borderSide: BorderSide(
      color: color,
      width: 1.0,
    ),
  );
}

// text style
final TextStyle bHeading1 =
    GoogleFonts.poppins(fontSize: 64, fontWeight: FontWeight.w500);
final TextStyle bHeading2 =
    GoogleFonts.poppins(fontSize: 48, fontWeight: FontWeight.w400);
final TextStyle bHeading3 =
    GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.w700);
final TextStyle bHeading4 =
    GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600);
final TextStyle bHeading5 =
    GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w400);
final TextStyle bHeading6 =
    GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500);
final TextStyle bHeading7 =
    GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700);
final TextStyle bSubtitle1 =
    GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400);
final TextStyle bSubtitle2 =
    GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500);
final TextStyle bSubtitle3 =
    GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500);
final TextStyle bSubtitle4 =
    GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w700);
final TextStyle bBody1 =
    GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400);
final TextStyle bBody2 =
    GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w400);
final TextStyle bCaption1 =
    GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w400);
final TextStyle bCaption2 =
    GoogleFonts.poppins(fontSize: 8, fontWeight: FontWeight.w400);
final TextStyle bCaption3 =
    GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w700);
final TextStyle bButton1 =
    GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500);
final TextStyle bButton2 =
    GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600);
final TextStyle bButton3 =
    GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w700);

// light theme
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: bBackgroundPrimary,
  primaryColor: bPrimary,
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.all(16),
    floatingLabelBehavior: FloatingLabelBehavior.never,
    enabledBorder: bBorderBuilder(bStroke),
    errorBorder: bBorderBuilder(bError),
    focusedErrorBorder: bBorderBuilder(bError),
    focusedBorder: bBorderBuilder(bPrimaryVariant1),
    disabledBorder: bBorderBuilder(bStroke),
    filled: true,
    fillColor: bTextPrimary,
    labelStyle: bSubtitle1.copyWith(color: bStroke),
    hintStyle: bSubtitle1.copyWith(color: bStroke),
    prefixIconColor: bPrimaryVariant1,
    suffixIconColor: bPrimaryVariant1,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(bPrimary),
      textStyle: MaterialStateProperty.all(
        bSubtitle4.copyWith(color: bTextPrimary),
      ),
      overlayColor: MaterialStateProperty.all(bPrimaryVariant1),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    ),
  ),
);

// dark theme
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xff1B222A),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.all(16),
    floatingLabelBehavior: FloatingLabelBehavior.never,
    enabledBorder: bBorderBuilder(bGrey),
    errorBorder: bBorderBuilder(bError),
    focusedErrorBorder: bBorderBuilder(bError),
    focusedBorder: bBorderBuilder(bTextPrimary),
    disabledBorder: bBorderBuilder(bStroke),
    filled: true,
    fillColor: bDarkGrey,
    labelStyle: bSubtitle1.copyWith(color: bGrey),
    hintStyle: bSubtitle1.copyWith(color: bGrey),
    prefixIconColor: bGrey,
    suffixIconColor: bGrey,
    focusColor: bError,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(bDarkGrey),
      textStyle: MaterialStateProperty.all(
        bSubtitle4.copyWith(color: bTextPrimary),
      ),
      overlayColor: MaterialStateProperty.all(bGrey),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    ),
  ),
);
