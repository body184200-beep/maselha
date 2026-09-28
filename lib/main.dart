import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'features/home/presentation/screens/Home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      builder: (context, child) => Directionality(
        textDirection: TextDirection.rtl,
        child: child!,
      ),
      theme: ThemeData(
        textTheme: GoogleFonts.cairoTextTheme(),
      ),
      home: const Home(),
    );
  }
}


