import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/custom_button.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 430),
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: const Color(0xFF334155), width: 6),
            boxShadow: const [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 25,
                offset: Offset(0, 10),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),
                  Center(
                    child: Container(
                      height: 110,
                      width: 110,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.school_rounded,
                        size: 60,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'Mahastudy',
                    style: AppTextStyles.heading1.copyWith(
                      fontSize: 32,
                      color: AppColors.primaryDark,
                      letterSpacing: -0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Aplikasi pengelola aktivitas akademik dan produktivitas mahasiswa untuk Kelompok 7.',
                    style: AppTextStyles.bodySecondary.copyWith(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  CustomButton(
                    text: 'Mulai Sekarang',
                    icon: Icons.arrow_forward_rounded,
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                  ),
                  const SizedBox(height: 12),
                  CustomButton(
                    text: 'Sudah Punya Akun? Masuk',
                    isSecondary: true,
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
