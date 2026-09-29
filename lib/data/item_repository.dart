// TAMBAHAN LATIHAN 2
import '../models/item.dart';

/// Sumber data sementara (dummy) bertema Mahastudy Kelompok 7.
class ItemRepository {
  static const List<Item> _items = [
    Item(
      id: '1',
      title: 'Pemrograman Mobile',
      subtitle: 'Latihan Modul 02 - Navigasi & UI States',
      description:
          'Mengerjakan latihan praktikum pertemuan 02 mengenai form validasi, status loading, empty state, error state, dan passing data antar layar.',
    ),
    Item(
      id: '2',
      title: 'Sistem Informasi Manajemen',
      subtitle: 'Analisis Dokumen PRD Sistem Kampus',
      description:
          'Melakukan review dan analisis kebutuhan pengguna berdasarkan dokumen PRD aplikasi Mahastudy Kelompok 7.',
    ),
    Item(
      id: '3',
      title: 'Basis Data Lanjut',
      subtitle: 'Praktikum Normalisasi & Query Optimization',
      description:
          'Implementasi pengindeksan database, view, dan optimasi query data transaksi akademik mahasiswa.',
    ),
  ];

  /// Mengambil daftar item dummy dengan simulasi delay 2 detik.
  /// simulateError: true -> sengaja dibuat gagal untuk menguji error state.
  Future<List<Item>> fetchItems({bool simulateError = false}) async {
    await Future.delayed(const Duration(seconds: 2));
    if (simulateError) {
      throw Exception('Gagal memuat data. Periksa koneksi internet.');
    }
    return _items;
  }
}
