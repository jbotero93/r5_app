import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:r5_app/utils/r5_colors.dart';

class R5AppBar {
  PreferredSizeWidget r5AppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: R5Colors.blue,
      title: Text(
        'Creando ToDo!',
        style: GoogleFonts.rubik(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
