import 'package:flutter/material.dart';
import '../models/schedule_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/schedule_card.dart';

class ScheduleScreen extends StatefulWidget {
  final List<ScheduleModel> schedules;
  final Function(ScheduleModel) onViewMap;

  const ScheduleScreen({
    super.key,
    required this.schedules,
    required this.onViewMap,
  });

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  ScheduleType _selectedType = ScheduleType.classSession;

  void _addScheduleDialog() {
    final titleController = TextEditingController();
    final roomController = TextEditingController();
    final timeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Tambah Jadwal Baru', style: AppTextStyles.heading2),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Nama Kuliah / Kegiatan',
                  hintText: 'misal: Pemrograman Mobile',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: roomController,
                decoration: const InputDecoration(
                  labelText: 'Ruang Kelas & Gedung',
                  hintText: 'misal: Lab 02 FTI',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: timeController,
                decoration: const InputDecoration(
                  labelText: 'Hari & Waktu',
                  hintText: 'misal: Rabu, 08:00 - 10:30',
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
                if (titleController.text.isNotEmpty) {
                  setState(() {
                    widget.schedules.add(
                      ScheduleModel(
                        id: DateTime.now().toString(),
                        title: titleController.text,
                        courseOrOrg: 'Akademik',
                        dayOrDate: timeController.text.isEmpty ? 'Senin, 08:00' : timeController.text,
                        timeRange: '08:00 - 10:00',
                        room: roomController.text.isEmpty ? 'Ruang K.101' : roomController.text,
                        building: 'Gedung Kuliah Unand',
                        mapCoordinates: 'Koordinat GPS Kampus Unand Limau Manis',
                        type: _selectedType,
                      ),
                    );
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Simpan Jadwal', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = widget.schedules.where((s) => s.type == _selectedType).toList();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Jadwal & Lokasi', style: AppTextStyles.heading1),
              IconButton.filled(
                style: IconButton.styleFrom(backgroundColor: AppColors.primary),
                onPressed: _addScheduleDialog,
                icon: const Icon(Icons.add_location_alt_rounded, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Jadwal Kuliah, Ujian, & Kegiatan Organisasi Kampus',
            style: AppTextStyles.bodySecondary,
          ),
          const SizedBox(height: 16),
          // Category Tabs
          Row(
            children: [
              Expanded(
                child: FilterChip(
                  label: const Text('Kuliah'),
                  selected: _selectedType == ScheduleType.classSession,
                  onSelected: (val) => setState(() => _selectedType = ScheduleType.classSession),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilterChip(
                  label: const Text('Ujian'),
                  selected: _selectedType == ScheduleType.exam,
                  onSelected: (val) => setState(() => _selectedType = ScheduleType.exam),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilterChip(
                  label: const Text('Organisasi'),
                  selected: _selectedType == ScheduleType.organization,
                  onSelected: (val) => setState(() => _selectedType = ScheduleType.organization),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.calendar_today_outlined, size: 64, color: AppColors.textMuted),
                        const SizedBox(height: 12),
                        Text('Belum ada jadwal di kategori ini', style: AppTextStyles.bodySecondary),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final item = filtered[index];
                      return ScheduleCard(
                        schedule: item,
                        onViewMap: () => widget.onViewMap(item),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
