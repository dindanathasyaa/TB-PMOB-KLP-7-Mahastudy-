class StudyPlanModel {
  final String id;
  final String courseName;
  final String date;
  final int targetMinutes;
  int completedMinutes;
  bool isCompleted;

  StudyPlanModel({
    required this.id,
    required this.courseName,
    required this.date,
    required this.targetMinutes,
    this.completedMinutes = 0,
    this.isCompleted = false,
  });

  double get progressRatio => (completedMinutes / targetMinutes).clamp(0.0, 1.0);
}
