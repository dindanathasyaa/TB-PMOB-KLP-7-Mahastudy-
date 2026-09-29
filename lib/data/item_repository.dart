import '../models/task_model.dart';
import '../models/schedule_model.dart';

class ItemRepository {
  // Sumber data dummy yang sebelumnya ada di HomeScreen
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

  // Simulasi proses asinkron untuk mengambil data Task
  Future<List<TaskModel>> getTasks() async {
    await Future.delayed(const Duration(seconds: 2));
    
    // Uncomment untuk menguji tampilan error:
    // throw Exception('Gagal memuat tugas');
    
    return _tasks;
  }

  // Simulasi proses asinkron untuk mengambil data Schedule
  Future<List<ScheduleModel>> getSchedules() async {
    await Future.delayed(const Duration(seconds: 2));
    return _schedules;
  }
}
