import 'package:flutter/material.dart';
// TAMBAHAN LATIHAN 2: Import AppRoutes
import 'routes/app_routes.dart';
import 'theme/app_colors.dart';

void main() {
  runApp(const MahastudyApp());
}

class MahastudyApp extends StatelessWidget {
  const MahastudyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mahastudy - Akademik & Produktivitas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          surface: AppColors.surface,
        ),
        useMaterial3: true,
      ),
      // TAMBAHAN LATIHAN 2: Rute awal Landing Screen (alur PRD)
      initialRoute: AppRoutes.landing,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      onUnknownRoute: AppRoutes.onUnknownRoute,
    );
  }
}
