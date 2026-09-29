import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../models/schedule_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/task_card.dart';
import '../widgets/schedule_card.dart';
import '../data/item_repository.dart';
import '../routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ItemRepository _repository = ItemRepository();
  
  List<TaskModel> _tasks = [];
  List<ScheduleModel> _schedules = [];
  
  bool _isLoading = true;
  bool _isError = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _isError = false;
      _errorMessage = '';
    });

    try {
      final tasks = await _repository.getTasks();
      final schedules = await _repository.getSchedules();
      
      if (!mounted) return;
      
      setState(() {
        _tasks = tasks;
        _schedules = schedules;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isError = true;
        _errorMessage = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

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
              child: _isLoading 
                ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
                : _isError 
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline, size: 48, color: AppColors.error),
                          const SizedBox(height: 16),
                          Text(_errorMessage.isNotEmpty ? _errorMessage : 'Gagal memuat data', style: AppTextStyles.heading2, textAlign: TextAlign.center),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _loadData,
                            child: const Text('Coba Lagi'),
                          ),
                        ],
                      ),
                    )
                  : _tasks.isEmpty && _schedules.isEmpty
                    ? Center(
                        child: Text('Tidak ada data.', style: AppTextStyles.bodySecondary),
                      )
                    : SingleChildScrollView(
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
                            ..._tasks.map((task) => GestureDetector(
                                  onTap: () async {
                                    // Navigasi ke detail dan terima data kembali (Langkah H)
                                    final result = await Navigator.pushNamed(
                                      context, 
                                      AppRoutes.taskDetail,
                                      arguments: task,
                                    );
                                    if (!context.mounted) return;
                                    if (result is String) {
                                      setState(() {
                                        task.notes = result;
                                      });
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Catatan berhasil diperbarui')),
                                      );
                                    }
                                  },
                                  child: TaskCard(
                                    task: task,
                                    onStatusChanged: (newStatus) {
                                      setState(() => task.status = newStatus);
                                    },
                                    onUploadProof: () => _showProofModal(task),
                                  ),
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
