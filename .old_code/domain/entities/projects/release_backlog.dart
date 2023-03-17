class ReleaseBacklog {
  final String id;
  final String projectId;
  final String? name;
  final String? description;
  final double priority;

  ReleaseBacklog({
    required this.id,
    required this.projectId,
    this.name,
    this.description,
    required this.priority,
  });
}
