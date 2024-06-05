import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase/color_constants.dart';

class TTextTheme{
  static TextTheme lightTextTheme= TextTheme(
    displayLarge: GoogleFonts.roboto(color: Colors.black87,fontSize: 38, fontWeight: FontWeight.bold ),
    displayMedium: GoogleFonts.roboto(color: Colors.black87,fontSize: 22, fontWeight: FontWeight.bold),
    displaySmall: GoogleFonts.roboto(color: Colors.black87,fontSize: 18, fontWeight: FontWeight.bold),
    titleMedium: GoogleFonts.poppins(color: Colors.grey,fontSize: 15,),
    titleSmall: GoogleFonts.poppins(color: Colors.grey,fontSize: 14,),
  );
  static TextTheme darkTextTheme= TextTheme(
    displayLarge: GoogleFonts.roboto(color: Colors.white70,fontSize: 38, fontWeight: FontWeight.bold ),
    displayMedium: GoogleFonts.roboto(color: Colors.white70,fontSize: 22,fontWeight: FontWeight.bold ),
    displaySmall: GoogleFonts.roboto(color: Colors.white70,fontSize: 18,fontWeight: FontWeight.bold ),
    titleMedium: GoogleFonts.poppins(color: AppColors.lightGrey,fontSize: 15,),
    titleSmall: GoogleFonts.poppins(color: AppColors.lightGrey,fontSize: 14,),

  );
}