import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// const String baseUrl = "http://udacoding.test:8080/";
const String baseUrl = "https://udafarm.nasiwebhost.com/news/";

// Colors that we use in our app
const kPrimaryColor = Color(0xFF0C9869);
const kTextColor = Color(0xFF3C4046);
const kBackgroundColor = Color(0xFFF9F8FD);

const double kDefaultPadding = 20.0;

const kGrey1 = Color(0xFF9F9F9F);
const kGrey2 = Color(0xFF6D6D6D);
const kGrey3 = Color(0xFFEAEAEA);
const kBlack = Color(0xFF1C1C1C);

var kNonActiveTabStyle = GoogleFonts.roboto(
  textStyle: TextStyle(fontSize: 14.0, color: kGrey1),
);

var kActiveTabStyle = GoogleFonts.roboto(
  textStyle: TextStyle(
    fontSize: 16.0,
    color: kBlack,
    fontWeight: FontWeight.bold,
  ),
);

var kCategoryTitle = GoogleFonts.roboto(
  textStyle: TextStyle(
    fontSize: 14.0,
    color: kGrey2,
    fontWeight: FontWeight.bold,
  ),
);

var kDetailContent = GoogleFonts.roboto(
  textStyle: TextStyle(
    fontSize: 14.0,
    color: kGrey2,
  ),
);

var kTitleCard = GoogleFonts.roboto(
  textStyle: TextStyle(
    fontSize: 18.0,
    color: kBlack,
    fontWeight: FontWeight.bold,
  ),
);

var descriptionStyle = GoogleFonts.roboto(
    textStyle: TextStyle(
  fontSize: 15.0,
  height: 2.0,
));
