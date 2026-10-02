import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/dio/app_dependencies.dart';
import 'features/home/presentation/screens/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDependencies.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      builder: (context, child) =>
          Directionality(textDirection: TextDirection.rtl, child: child!),
      theme: ThemeData(textTheme: GoogleFonts.cairoTextTheme()),
      home: const Home(),
    );
  }
}