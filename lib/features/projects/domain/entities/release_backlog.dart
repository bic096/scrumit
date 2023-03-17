class ReleaseBacklog {
  final String id;
  final String projectId;
  final String name;
  final String description;
  final String priority;
  final DateTime createdAt;
  final String type;
  final String? sprintId;

  ReleaseBacklog(
      {required this.id,
      required this.projectId,
      required this.name,
      required this.description,
      required this.priority,
      required this.createdAt,
      required this.type,
      this.sprintId});
  ReleaseBacklog copyWith(
      {String? name,
      String? description,
      String? priority,
      String? type,
      String? sprintId}) {
    return ReleaseBacklog(
        projectId: projectId,
        name: name ?? this.name,
        description: description ?? this.description,
        priority: priority ?? this.priority,
        createdAt: createdAt,
        id: id,
        type: type ?? this.type,
        sprintId: sprintId ?? this.sprintId);
  }

  @override
  String toString() {
    return '''
        id: $id
        projectId: $projectId
        Name: $name
        createdAt: $createdAt
        description: $description
        priority: $priority
''';
  }
}
