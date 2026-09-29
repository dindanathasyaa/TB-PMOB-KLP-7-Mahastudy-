import '../models/task_model.dart';

/// Sumber data sementara (dummy). Nanti bisa diganti dengan API/database.
class TaskRepository {
  static final List<TaskModel> _items = [
    TaskModel(
      id: '1',
      courseName: 'Pemrograman Mobile',
      title: 'Tugas Praktikum 2',
      deadline: DateTime.now().add(const Duration(days: 2)),
      priority: TaskPriority.high,
      notes: 'Mengerjakan validasi dan state management di Flutter.',
    ),
    TaskModel(
      id: '2',
      courseName: 'Sistem Operasi',
      title: 'Makalah Penjadwalan',
      deadline: DateTime.now().add(const Duration(days: 5)),
      priority: TaskPriority.medium,
      notes: 'Membuat makalah tentang algoritma penjadwalan CPU.',
    ),
    TaskModel(
      id: '3',
      courseName: 'Basis Data',
      title: 'Desain ERD',
      deadline: DateTime.now().add(const Duration(days: 7)),
      priority: TaskPriority.low,
      notes: 'Membuat Entity Relationship Diagram untuk studi kasus toko online.',
    ),
  ];

  /// Mengambil daftar item.
  /// simulateError: true -> sengaja dibuat gagal untuk menguji error state.
  Future<List<TaskModel>> fetchItems({bool simulateError = false}) async {
    await Future.delayed(const Duration(seconds: 2)); // simulasi waktu tunggu server
    if (simulateError) {
      throw Exception('Gagal memuat data. Periksa koneksi internet.');
    }
    return _items;
  }
}
