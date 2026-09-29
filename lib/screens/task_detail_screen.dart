import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../routes/app_routes.dart';
import '../widgets/custom_button.dart';

class TaskDetailScreen extends StatefulWidget {
  final TaskModel task;
  
  const TaskDetailScreen({super.key, required this.task});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late String _currentNotes;

  @override
  void initState() {
    super.initState();
    _currentNotes = widget.task.notes;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) return;
        Navigator.pop(context, _currentNotes);
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0F172A),
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 430),
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: const Color(0xFF334155), width: 6),
            ),
            clipBehavior: Clip.antiAlias,
            child: Scaffold(
              backgroundColor: AppColors.background,
              appBar: AppBar(
                backgroundColor: AppColors.surface,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
                  onPressed: () {
                    Navigator.pop(context, _currentNotes);
                  },
                ),
                title: Text('Detail Tugas', style: AppTextStyles.heading2),
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.task.courseName, style: AppTextStyles.caption.copyWith(color: AppColors.primary)),
                      const SizedBox(height: 8),
                      Text(widget.task.title, style: AppTextStyles.heading1),
                      const SizedBox(height: 24),
                      Container(
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
                                Text('Catatan Tambahan', style: AppTextStyles.heading3),
                                const Icon(Icons.edit_note_rounded, color: AppColors.textSecondary),
                              ],
                            ),
                            const Divider(height: 24),
                            Text(
                              _currentNotes.isEmpty ? 'Belum ada catatan' : _currentNotes, 
                              style: AppTextStyles.body,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      CustomButton(
                        text: 'Edit Catatan',
                        icon: Icons.edit_rounded,
                        onPressed: () async {
                          final result = await Navigator.pushNamed(
                            context, 
                            AppRoutes.noteForm,
                            arguments: _currentNotes,
                          );
                          if (result is String && mounted) {
                            setState(() {
                              _currentNotes = result;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
