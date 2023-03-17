class Task {
  final String id;
  // final String backlogId;
  final List<String> usersIds;
  final String status;
  final String sprintId;
  final String? description;
  final String type;
  final String? priority;

  Task(
      {required this.id,
      // required this.backlogId,
      required this.usersIds,
      required this.status,
      required this.sprintId,
      required this.description,
      required this.type,
      required this.priority});

  Task copyWith({String? status, List<String>? usersIds}) => Task(
      id: id,
      usersIds: usersIds ?? this.usersIds,
      status: status ?? this.status,
      sprintId: sprintId,
      description: description,
      type: type,
      priority: priority);

  @override
  String toString() {
    return '''
                final String $id;
                final String $description;
                final List<String> $usersIds;
                final String $status;
                final String $sprintId;
                ''';
  }
}
