import 'package:flutter/material.dart';
import 'theme/app_colors.dart';
import 'routes/app_routes.dart';

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
      initialRoute: AppRoutes.landing,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
