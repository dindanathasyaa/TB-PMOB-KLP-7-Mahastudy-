import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../models/schedule_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/task_card.dart';
import '../widgets/schedule_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Mock Data Halaman Home (PRD Kelompok 7)
  final List<TaskModel> _tasks = [
    TaskModel(
      id: 't1',
      courseName: 'Pemrograman Mobile',
      title: 'Laporan Praktikum Modul 01',
      deadline: DateTime.now().add(const Duration(days: 1)),
      priority: TaskPriority.high,
      status: TaskStatus.inProgress,
      notes: 'Ekstrak kode Flutter & bukti screenshot',
    ),
    TaskModel(
      id: 't2',
      courseName: 'Sistem Informasi Manajemen',
      title: 'Analisis PRD Sistem Kampus',
      deadline: DateTime.now().add(const Duration(days: 3)),
      priority: TaskPriority.medium,
      status: TaskStatus.todo,
      notes: 'Format PDF maksimal 5MB',
    ),
  ];

  final List<ScheduleModel> _schedules = [
    ScheduleModel(
      id: 's1',
      title: 'Praktikum Pemrograman Mobile',
      courseOrOrg: 'Sistem Informasi',
      dayOrDate: 'Selasa, 13:30 WIB',
      timeRange: '13:30 - 16:00',
      room: 'Lab Komputer 02',
      building: 'Gedung FTI Unand',
      mapCoordinates: 'R. Lab 02, Lantai 2 Gedung FTI',
      type: ScheduleType.classSession,
    ),
    ScheduleModel(
      id: 's2',
      title: 'Rapat Organisasi HIMA SI',
      courseOrOrg: 'Himpunan Mahasiswa',
      dayOrDate: 'Rabu, 16:30 WIB',
      timeRange: '16:30 - 18:00',
      room: 'Ruang Sekretariat',
      building: 'Gedung PKM Unand',
      mapCoordinates: 'Sekretariat HIMA SI PKM',
      type: ScheduleType.organization,
    ),
  ];

  void _showLocationModal(ScheduleModel schedule) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.pin_drop_rounded, color: AppColors.primary, size: 28),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('Peta Lokasi Ruang Kelas', style: AppTextStyles.heading2),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text('Mata Kuliah: ${schedule.title}', style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text('Lokasi: ${schedule.room} - ${schedule.building}', style: AppTextStyles.bodySecondary),
              const SizedBox(height: 16),
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primary),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.map_rounded, size: 40, color: AppColors.primary),
                      const SizedBox(height: 6),
                      Text('GPS Coordinates: ${schedule.mapCoordinates}', style: AppTextStyles.caption.copyWith(color: AppColors.primaryDark, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Tutup Peta', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showProofModal(TaskModel task) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Upload Bukti Pengerjaan Tugas', style: AppTextStyles.heading2),
              const SizedBox(height: 6),
              Text('Tugas: ${task.title}', style: AppTextStyles.bodySecondary),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  setState(() {
                    task.proofFilePath = 'bukti_${task.id}.png';
                    task.status = TaskStatus.completed;
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('🎉 Bukti tugas ${task.title} berhasil diunggah!'),
                      backgroundColor: AppColors.success,
                    ),
                  );
                },
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.primary),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cloud_upload_outlined, size: 36, color: AppColors.primary),
                      SizedBox(height: 6),
                      Text('Klik untuk Pilih Screenshot Bukti', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final completedCount = _tasks.where((t) => t.status == TaskStatus.completed).length;
    final totalCount = _tasks.length;
    final progressRatio = totalCount > 0 ? completedCount / totalCount : 0.0;

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
          child: Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              backgroundColor: AppColors.surface,
              elevation: 0,
              title: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: AppColors.primaryLight,
                    child: Icon(Icons.person_rounded, color: AppColors.primary),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Halo, Mahasiswa SI!', style: AppTextStyles.heading3),
                      Text('Mahastudy - Halaman Home', style: AppTextStyles.caption),
                    ],
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications_none_rounded, color: AppColors.textPrimary),
                  onPressed: () {},
                ),
              ],
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Banner Ringkasan Progres Akademik
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.primary, AppColors.primaryDark],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Progres Tugas Akademik', style: AppTextStyles.heading3.copyWith(color: Colors.white)),
                              Text('${(progressRatio * 100).toInt()}% Selesai', style: AppTextStyles.caption.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              value: progressRatio,
                              minHeight: 8,
                              backgroundColor: Colors.white.withValues(alpha: 0.3),
                              color: AppColors.success,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text('$completedCount dari $totalCount tugas telah diselesaikan.', style: AppTextStyles.caption.copyWith(color: Colors.white.withValues(alpha: 0.9))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Section Tugas & Deadline Terdekat
                    Text('Tugas & Deadline Terdekat', style: AppTextStyles.heading2),
                    const SizedBox(height: 12),
                    ..._tasks.map((task) => TaskCard(
                          task: task,
                          onStatusChanged: (newStatus) {
                            setState(() => task.status = newStatus);
                          },
                          onUploadProof: () => _showProofModal(task),
                        )),
                    const SizedBox(height: 24),
                    // Section Jadwal Kuliah Hari Ini
                    Text('Jadwal Kuliah Hari Ini', style: AppTextStyles.heading2),
                    const SizedBox(height: 12),
                    ..._schedules.map((schedule) => ScheduleCard(
                          schedule: schedule,
                          onViewMap: () => _showLocationModal(schedule),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
