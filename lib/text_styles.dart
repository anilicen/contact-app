import 'package:contact_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle getBold24({Color color = cpBlack}) {
  return GoogleFonts.nunito(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: color,
  );
}

TextStyle getMedium16({Color color = cpBlack}) {
  return GoogleFonts.nunito(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: color,
  );
}

TextStyle getBold16({Color color = cpBlack}) {
  return GoogleFonts.nunito(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: color,
  );
}
