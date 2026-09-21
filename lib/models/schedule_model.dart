enum ScheduleType { classSession, exam, organization }

class ScheduleModel {
  final String id;
  final String title;
  final String courseOrOrg;
  final String dayOrDate;
  final String timeRange;
  final String room;
  final String building;
  final String mapCoordinates;
  final ScheduleType type;

  ScheduleModel({
    required this.id,
    required this.title,
    required this.courseOrOrg,
    required this.dayOrDate,
    required this.timeRange,
    required this.room,
    required this.building,
    required this.mapCoordinates,
    this.type = ScheduleType.classSession,
  });

  String get typeLabel {
    switch (type) {
      case ScheduleType.classSession:
        return 'Jadwal Kuliah';
      case ScheduleType.exam:
        return 'Jadwal Ujian';
      case ScheduleType.organization:
        return 'Kegiatan Organisasi';
    }
  }
}
