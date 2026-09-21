import 'package:flutter/material.dart';
import '../models/schedule_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class ScheduleCard extends StatelessWidget {
  final ScheduleModel schedule;
  final VoidCallback onViewMap;

  const ScheduleCard({
    super.key,
    required this.schedule,
    required this.onViewMap,
  });

  IconData _getTypeIcon() {
    switch (schedule.type) {
      case ScheduleType.classSession:
        return Icons.school_rounded;
      case ScheduleType.exam:
        return Icons.assignment_late_rounded;
      case ScheduleType.organization:
        return Icons.groups_rounded;
    }
  }

  Color _getTypeColor() {
    switch (schedule.type) {
      case ScheduleType.classSession:
        return AppColors.primary;
      case ScheduleType.exam:
        return AppColors.priorityHigh;
      case ScheduleType.organization:
        return AppColors.warning;
    }
  }

  @override
  Widget build(BuildContext context) {
    final typeColor = _getTypeColor();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Badge Icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: typeColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(_getTypeIcon(), size: 28, color: typeColor),
          ),
          const SizedBox(width: 14),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      schedule.typeLabel,
                      style: AppTextStyles.caption.copyWith(
                        color: typeColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      schedule.dayOrDate,
                      style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  schedule.title,
                  style: AppTextStyles.heading3,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.access_time_rounded, size: 14, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(schedule.timeRange, style: AppTextStyles.bodySecondary.copyWith(fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 14, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(
                      '${schedule.room} (${schedule.building})',
                      style: AppTextStyles.bodySecondary.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primary, width: 1.2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  ),
                  onPressed: onViewMap,
                  icon: const Icon(Icons.map_outlined, size: 16, color: AppColors.primary),
                  label: const Text(
                    'Lihat Lokasi Ruang (GPS/Maps)',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
