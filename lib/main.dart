import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:m_commerce/screens/landing_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //google fonts
       theme: ThemeData(
      //   textTheme: GoogleFonts.poppinsTextTheme(
      //     Theme.of(context).textTheme,
      //   ),
      ),
      home: LandingPage(),
    );
  }
}