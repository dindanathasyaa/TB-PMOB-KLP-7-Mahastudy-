import 'package:flutter/material.dart';
import '../models/study_plan_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/study_timer_widget.dart';

class StudyPlannerScreen extends StatefulWidget {
  const StudyPlannerScreen({super.key});

  @override
  State<StudyPlannerScreen> createState() => _StudyPlannerScreenState();
}

class _StudyPlannerScreenState extends State<StudyPlannerScreen> {
  final List<StudyPlanModel> _plans = [
    StudyPlanModel(
      id: 'sp1',
      courseName: 'Pemrograman Mobile',
      date: 'Hari Ini',
      targetMinutes: 50,
      completedMinutes: 25,
    ),
    StudyPlanModel(
      id: 'sp2',
      courseName: 'Sistem Informasi Manajemen',
      date: 'Besok',
      targetMinutes: 60,
      completedMinutes: 0,
    ),
  ];

  void _addPlanDialog() {
    final courseController = TextEditingController();
    final targetController = TextEditingController(text: '30');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Tambah Rencana Belajar', style: AppTextStyles.heading2),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: courseController,
                decoration: const InputDecoration(
                  labelText: 'Mata Kuliah / Topik Belajar',
                  hintText: 'misal: Belajar Widget Tree Flutter',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: targetController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Target Menit Belajar',
                  hintText: 'misal: 45',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
              onPressed: () {
                if (courseController.text.isNotEmpty) {
                  setState(() {
                    _plans.add(
                      StudyPlanModel(
                        id: DateTime.now().toString(),
                        courseName: courseController.text,
                        date: 'Hari Ini',
                        targetMinutes: int.tryParse(targetController.text) ?? 30,
                      ),
                    );
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Simpan Rencana', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Study Planner & Timer', style: AppTextStyles.heading1),
              IconButton.filled(
                style: IconButton.styleFrom(backgroundColor: AppColors.primary),
                onPressed: _addPlanDialog,
                icon: const Icon(Icons.add_task_rounded, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Rencanakan target belajar dan jalankan timer sesi fokus',
            style: AppTextStyles.bodySecondary,
          ),
          const SizedBox(height: 20),
          // Interactive Study Timer
          StudyTimerWidget(
            initialMinutes: 25,
            onSessionCompleted: (minutes) {
              if (_plans.isNotEmpty) {
                setState(() {
                  _plans.first.completedMinutes += minutes;
                  if (_plans.first.completedMinutes >= _plans.first.targetMinutes) {
                    _plans.first.isCompleted = true;
                  }
                });
              }
            },
          ),
          const SizedBox(height: 24),
          // Target Plans Header
          Text('Target Rencana Belajar', style: AppTextStyles.heading2),
          const SizedBox(height: 12),
          ..._plans.map((plan) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(plan.courseName, style: AppTextStyles.heading3),
                      Text(
                        '${plan.completedMinutes} / ${plan.targetMinutes} Menit',
                        style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.bold, color: AppColors.primary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: plan.progressRatio,
                      minHeight: 8,
                      backgroundColor: AppColors.primaryLight,
                      color: plan.isCompleted ? AppColors.success : AppColors.primary,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
