import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../models/schedule_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/task_card.dart';
import '../widgets/schedule_card.dart';
import 'task_list_screen.dart';
import 'schedule_screen.dart';
import 'study_planner_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  // Mock State Data
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
                    child: Text(
                      'Peta Lokasi Ruang Kelas',
                      style: AppTextStyles.heading2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Mata Kuliah: ${schedule.title}',
                style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                'Lokasi: ${schedule.room} - ${schedule.building}',
                style: AppTextStyles.bodySecondary,
              ),
              const SizedBox(height: 16),
              // Map Mock Container
              Container(
                height: 140,
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
                      const Icon(Icons.map_rounded, size: 48, color: AppColors.primary),
                      const SizedBox(height: 8),
                      Text(
                        'GPS Coordinates: ${schedule.mapCoordinates}',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.primaryDark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.all(12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
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
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            top: 24,
            left: 24,
            right: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Upload Bukti Pengerjaan Tugas',
                style: AppTextStyles.heading2,
              ),
              const SizedBox(height: 6),
              Text(
                'Tugas: ${task.title}',
                style: AppTextStyles.bodySecondary,
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  setState(() {
                    task.proofFilePath = 'screenshot_bukti_${task.id}.png';
                    task.status = TaskStatus.completed;
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('🎉 Bukti tugas ${task.title} berhasil diunggah! Status: SELESAI'),
                      backgroundColor: AppColors.success,
                    ),
                  );
                },
                child: Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.primary, style: BorderStyle.solid),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cloud_upload_outlined, size: 40, color: AppColors.primary),
                      SizedBox(height: 8),
                      Text('Klik untuk Pilih Foto / Screenshot', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
                      Text('Format PNG/JPG (Maks 5MB)', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
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

  Widget _buildDashboardHome() {
    final completedCount = _tasks.where((t) => t.status == TaskStatus.completed).length;
    final totalCount = _tasks.length;
    final progressRatio = totalCount > 0 ? completedCount / totalCount : 0.0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting & Profile Header
          Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.primaryLight,
                child: Icon(Icons.person_rounded, color: AppColors.primary, size: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Halo, Mahasiswa SI!', style: AppTextStyles.heading2),
                    Text('Mahastudy - Academic Dashboard', style: AppTextStyles.caption),
                  ],
                ),
              ),
              IconButton.filledTonal(
                onPressed: () {},
                icon: const Icon(Icons.notifications_active_outlined, color: AppColors.primary),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Progress Summary Banner
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ringkasan Progres Tugas',
                      style: AppTextStyles.heading3.copyWith(color: Colors.white),
                    ),
                    Text(
                      '${(progressRatio * 100).toInt()}% Selesai',
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                const SizedBox(height: 12),
                Text(
                  '$completedCount dari $totalCount tugas akademik telah diselesaikan.',
                  style: AppTextStyles.caption.copyWith(color: Colors.white.withValues(alpha: 0.9)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Deadlines Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tugas & Deadline Terdekat', style: AppTextStyles.heading2),
              GestureDetector(
                onTap: () => setState(() => _currentIndex = 1),
                child: Text(
                  'Lihat Semua',
                  style: AppTextStyles.caption.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ..._tasks.map((task) => TaskCard(
                task: task,
                onStatusChanged: (newStatus) {
                  setState(() => task.status = newStatus);
                },
                onUploadProof: () => _showProofModal(task),
              )),
          const SizedBox(height: 24),
          // Class Schedule Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Jadwal Kuliah Hari Ini', style: AppTextStyles.heading2),
              GestureDetector(
                onTap: () => setState(() => _currentIndex = 2),
                child: Text(
                  'Jadwal Lengkap',
                  style: AppTextStyles.caption.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ..._schedules.map((schedule) => ScheduleCard(
                schedule: schedule,
                onViewMap: () => _showLocationModal(schedule),
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildDashboardHome(),
      TaskListScreen(tasks: _tasks, onShowProofModal: _showProofModal),
      ScheduleScreen(schedules: _schedules, onViewMap: _showLocationModal),
      const StudyPlannerScreen(),
    ];

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
            body: SafeArea(child: pages[_currentIndex]),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),
              selectedItemColor: AppColors.primary,
              unselectedItemColor: AppColors.textMuted,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), label: 'Dashboard'),
                BottomNavigationBarItem(icon: Icon(Icons.task_alt_rounded), label: 'Tugas'),
                BottomNavigationBarItem(icon: Icon(Icons.calendar_month_rounded), label: 'Jadwal'),
                BottomNavigationBarItem(icon: Icon(Icons.timer_rounded), label: 'Study Timer'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
