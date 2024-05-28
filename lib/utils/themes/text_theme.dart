import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme light = TextTheme(
  displayLarge: GoogleFonts.poppins(
      fontFeatures: null,
      fontSize: 24.h,
      color: Color(0xff1D1C22),
      fontWeight: FontWeight.w600),
  displayMedium: GoogleFonts.poppins(
      fontSize: 18.h, color: Color(0xff1D1C22), fontWeight: FontWeight.w500),
  displaySmall: GoogleFonts.poppins(
      fontSize: 12.h, color: Color(0xff1D1C22), fontWeight: FontWeight.w400),
);
TextTheme dark = TextTheme(
  displayLarge: GoogleFonts.poppins(
      fontSize: 24.h, color: Color(0xffF6F9FE), fontWeight: FontWeight.w600),
  displayMedium: GoogleFonts.poppins(
      fontFeatures: null,
      fontSize: 18.h,
      color: Color(0xffF6F9FE),
      fontWeight: FontWeight.w500),
  displaySmall: GoogleFonts.poppins(
      fontSize: 12.h, color: Color(0xffF6F9FE), fontWeight: FontWeight.w400),
);
