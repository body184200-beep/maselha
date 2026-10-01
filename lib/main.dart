import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/dio/app_dependencies.dart';
import 'features/home/presentation/screens/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDependencies.init();

  unawaited(_debugPrintApi()); // TODO: remove once the API is wired

  runApp(const MyApp());
}

/// Temporary: prints what each endpoint returns to the Debug Console.
Future<void> _debugPrintApi() async {
  final api = AppDependencies.maselhaApi;
  final calls = {
    'categories': api.categories(),
    'difficulty-levels': api.difficultyLevels(),
    'random-word': api.randomWord(),
  };
  for (final entry in calls.entries) {
    (await entry.value).fold(
          (failure) => debugPrint('❌ ${entry.key}: ${failure.message}'),
          (json) => debugPrint('✅ ${entry.key}: $json'),
    );
  }
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