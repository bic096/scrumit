class Project {
  Project({
    required this.projectName,
    this.projectId,
    required this.ownerId,
    this.createdAt,
    required this.startDate,
    required this.endDate,
    required this.description,
  });

  final String projectName;
  String? projectId;
  final String ownerId;
  DateTime? createdAt;
  final DateTime startDate;
  final DateTime endDate;
  final String description;
}
