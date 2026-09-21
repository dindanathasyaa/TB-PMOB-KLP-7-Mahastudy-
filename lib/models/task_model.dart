enum TaskPriority { high, medium, low }
enum TaskStatus { todo, inProgress, completed }

class TaskModel {
  final String id;
  final String courseName;
  final String title;
  final DateTime deadline;
  final TaskPriority priority;
  TaskStatus status;
  String? proofFilePath;
  final String notes;

  TaskModel({
    required this.id,
    required this.courseName,
    required this.title,
    required this.deadline,
    required this.priority,
    this.status = TaskStatus.todo,
    this.proofFilePath,
    this.notes = '',
  });

  String get priorityLabel {
    switch (priority) {
      case TaskPriority.high:
        return 'Tinggi';
      case TaskPriority.medium:
        return 'Sedang';
      case TaskPriority.low:
        return 'Rendah';
    }
  }

  String get statusLabel {
    switch (status) {
      case TaskStatus.todo:
        return 'Belum Dikerjakan';
      case TaskStatus.inProgress:
        return 'Sedang Dikerjakan';
      case TaskStatus.completed:
        return 'Selesai';
    }
  }
}
