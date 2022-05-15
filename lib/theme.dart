import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color primaryTextColor = const Color(0xffFFFFFF);
Color secondaryTextColor = const Color(0xff81879C);
Color backgroundColor = const Color(0xff06133E);
Color bgPrimaryColor = const Color(0xff4AD0EE);
Color bgSecondaryColor = const Color(0xff2C3858);
Color iconActive = const Color(0xffFCFCFC);
Color iconInactive = const Color(0xff0C1533);

TextStyle titleTextStyle = GoogleFonts.poppins(
  color: primaryTextColor,
  fontWeight: FontWeight.bold,
  fontSize: 26,
);

TextStyle subTitleTextStyle = GoogleFonts.poppins(
  color: secondaryTextColor,
  fontWeight: FontWeight.w300,
  fontSize: 26,
);

TextStyle deviceTextStyle = GoogleFonts.poppins(
  color: primaryTextColor,
  fontWeight: FontWeight.w600,
  fontSize: 26,
);

TextStyle deviceStatusTextStyle = GoogleFonts.poppins(
  color: primaryTextColor,
  fontWeight: FontWeight.w500,
  fontSize: 14,
);

TextStyle weateherDate = GoogleFonts.poppins(
  color: primaryTextColor,
  fontSize: 18,
);

TextStyle weateherTemp = GoogleFonts.poppins(
  color: primaryTextColor,
  fontWeight: FontWeight.bold,
  fontSize: 42,
);

TextStyle weateherStatus = GoogleFonts.poppins(
  color: primaryTextColor,
  fontWeight: FontWeight.w500,
  fontSize: 28,
);

TextStyle weateherLocation = GoogleFonts.poppins(
  color: primaryTextColor,
  fontSize: 18,
);

TextStyle command = GoogleFonts.poppins(
  color: primaryTextColor,
  fontSize: 32,
  fontWeight: FontWeight.w400,
);

TextStyle commandHighLight = GoogleFonts.poppins(
  color: secondaryTextColor,
  fontSize: 32,
  fontWeight: FontWeight.w400,
);
