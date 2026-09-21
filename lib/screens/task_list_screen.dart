import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/task_card.dart';

class TaskListScreen extends StatefulWidget {
  final List<TaskModel> tasks;
  final Function(TaskModel) onShowProofModal;

  const TaskListScreen({
    super.key,
    required this.tasks,
    required this.onShowProofModal,
  });

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  String _selectedFilter = 'Semua';

  void _addNewTaskDialog() {
    final titleController = TextEditingController();
    final courseController = TextEditingController();
    TaskPriority priority = TaskPriority.medium;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Tambah Tugas Baru', style: AppTextStyles.heading2),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: courseController,
                decoration: const InputDecoration(
                  labelText: 'Mata Kuliah',
                  hintText: 'misal: Pemrograman Mobile',
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Judul Tugas',
                  hintText: 'misal: Laporan Modul 01',
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Prioritas: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  DropdownButton<TaskPriority>(
                    value: priority,
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => priority = val);
                      }
                    },
                    items: const [
                      DropdownMenuItem(value: TaskPriority.high, child: Text('Tinggi (Red)')),
                      DropdownMenuItem(value: TaskPriority.medium, child: Text('Sedang (Orange)')),
                      DropdownMenuItem(value: TaskPriority.low, child: Text('Rendah (Blue)')),
                    ],
                  ),
                ],
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
                    widget.tasks.add(
                      TaskModel(
                        id: DateTime.now().toString(),
                        courseName: courseController.text.isEmpty ? 'Umum' : courseController.text,
                        title: titleController.text,
                        deadline: DateTime.now().add(const Duration(days: 2)),
                        priority: priority,
                      ),
                    );
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Simpan Tugas', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredTasks = widget.tasks.where((task) {
      if (_selectedFilter == 'Tinggi') return task.priority == TaskPriority.high;
      if (_selectedFilter == 'Sedang') return task.priority == TaskPriority.medium;
      if (_selectedFilter == 'Selesai') return task.status == TaskStatus.completed;
      return true;
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Manajemen Tugas', style: AppTextStyles.heading1),
              IconButton.filled(
                style: IconButton.styleFrom(backgroundColor: AppColors.primary),
                onPressed: _addNewTaskDialog,
                icon: const Icon(Icons.add_rounded, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Atur deadline, prioritas, dan upload bukti pengerjaan',
            style: AppTextStyles.bodySecondary,
          ),
          const SizedBox(height: 16),
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ['Semua', 'Tinggi', 'Sedang', 'Selesai'].map((filter) {
                final isSelected = _selectedFilter == filter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(filter),
                    selected: isSelected,
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _selectedFilter = filter);
                      }
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: filteredTasks.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.assignment_turned_in_outlined, size: 64, color: AppColors.textMuted),
                        const SizedBox(height: 12),
                        Text('Tidak ada tugas di kategori ini', style: AppTextStyles.bodySecondary),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index];
                      return TaskCard(
                        task: task,
                        onStatusChanged: (newStatus) {
                          setState(() => task.status = newStatus);
                        },
                        onUploadProof: () => widget.onShowProofModal(task),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
