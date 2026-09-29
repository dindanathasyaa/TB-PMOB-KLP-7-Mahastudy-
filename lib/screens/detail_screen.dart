import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../routes/app_routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class DetailScreen extends StatefulWidget {
  final TaskModel item;
  const DetailScreen({super.key, required this.item});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String? _catatan;

  Future<void> _bukaFormCatatan() async {
    final hasil = await Navigator.pushNamed<String>(
      context,
      AppRoutes.catatanForm,
    );
    if (!mounted || hasil == null) return; // null = pengguna batal
    setState(() => _catatan = hasil);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Catatan berhasil disimpan')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final task = widget.item;
    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
        backgroundColor: AppColors.surface,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        titleTextStyle: AppTextStyles.heading3.copyWith(color: AppColors.textPrimary),
      ),
      backgroundColor: AppColors.background,
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task.title, style: AppTextStyles.heading2),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.book_outlined, size: 16, color: AppColors.textSecondary),
                    const SizedBox(width: 6),
                    Text(task.courseName, style: AppTextStyles.bodySecondary),
                  ],
                ),
                const SizedBox(height: 16),
                Text('Catatan Tugas:', style: AppTextStyles.heading3),
                const SizedBox(height: 4),
                Text(task.notes, style: AppTextStyles.body),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Divider(height: 32, color: AppColors.border),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _catatan == null ? AppColors.surface : AppColors.primaryLight.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _catatan == null ? AppColors.border : AppColors.primary),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.edit_note, color: _catatan == null ? AppColors.textSecondary : AppColors.primary),
                    const SizedBox(width: 8),
                    Text('Catatan Pribadi', style: AppTextStyles.heading3),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  _catatan == null ? 'Belum ada catatan.' : _catatan!,
                  style: AppTextStyles.body.copyWith(
                    fontStyle: _catatan == null ? FontStyle.italic : FontStyle.normal,
                    color: _catatan == null ? AppColors.textSecondary : AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _bukaFormCatatan,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            icon: const Icon(Icons.edit_note),
            label: const Text('Tulis Catatan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
