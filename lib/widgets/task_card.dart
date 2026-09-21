import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final Function(TaskStatus) onStatusChanged;
  final VoidCallback onUploadProof;
  final VoidCallback? onDelete;

  const TaskCard({
    super.key,
    required this.task,
    required this.onStatusChanged,
    required this.onUploadProof,
    this.onDelete,
  });

  Color _getPriorityColor() {
    switch (task.priority) {
      case TaskPriority.high:
        return AppColors.priorityHigh;
      case TaskPriority.medium:
        return AppColors.priorityMedium;
      case TaskPriority.low:
        return AppColors.priorityLow;
    }
  }

  Color _getStatusColor() {
    switch (task.status) {
      case TaskStatus.todo:
        return AppColors.textMuted;
      case TaskStatus.inProgress:
        return AppColors.warning;
      case TaskStatus.completed:
        return AppColors.success;
    }
  }

  @override
  Widget build(BuildContext context) {
    final priorityColor = _getPriorityColor();
    final statusColor = _getStatusColor();
    final isCompleted = task.status == TaskStatus.completed;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCompleted ? AppColors.success.withValues(alpha: 0.5) : AppColors.border,
          width: isCompleted ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Category/Matkul & Priority Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  task.courseName.toUpperCase(),
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: priorityColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Prioritas ${task.priorityLabel}',
                  style: AppTextStyles.caption.copyWith(
                    color: priorityColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Task Title
          Text(
            task.title,
            style: AppTextStyles.heading3.copyWith(
              decoration: isCompleted ? TextDecoration.lineThrough : null,
              color: isCompleted ? AppColors.textMuted : AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          // Deadline Row
          Row(
            children: [
              const Icon(Icons.access_time_rounded, size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 6),
              Text(
                'Deadline: ${task.deadline.day}/${task.deadline.month}/${task.deadline.year}',
                style: AppTextStyles.bodySecondary.copyWith(fontSize: 13),
              ),
            ],
          ),
          if (task.proofFilePath != null && task.proofFilePath!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.verified_rounded, size: 16, color: AppColors.success),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Bukti: ${task.proofFilePath}',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.success,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
          const Divider(height: 24, color: AppColors.border),
          // Action Buttons: Change Status & Upload Proof
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Status Dropdown / Button
              PopupMenuButton<TaskStatus>(
                initialValue: task.status,
                onSelected: onStatusChanged,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isCompleted ? Icons.check_circle_rounded : Icons.pending_rounded,
                        size: 16,
                        color: statusColor,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        task.statusLabel,
                        style: AppTextStyles.caption.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.arrow_drop_down, size: 18, color: statusColor),
                    ],
                  ),
                ),
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: TaskStatus.todo,
                    child: Text('Belum Dikerjakan'),
                  ),
                  PopupMenuItem(
                    value: TaskStatus.inProgress,
                    child: Text('Sedang Dikerjakan'),
                  ),
                  PopupMenuItem(
                    value: TaskStatus.completed,
                    child: Text('Selesai (Butuh Bukti)'),
                  ),
                ],
              ),
              // Button Upload Bukti
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isCompleted ? AppColors.success : AppColors.primaryLight,
                  foregroundColor: isCompleted ? Colors.white : AppColors.primary,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: onUploadProof,
                icon: Icon(
                  isCompleted ? Icons.image_outlined : Icons.upload_file_rounded,
                  size: 16,
                ),
                label: Text(
                  isCompleted ? 'Bukti Diterima' : 'Upload Bukti',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
