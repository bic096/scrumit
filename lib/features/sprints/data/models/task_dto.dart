import 'package:scrumit/features/sprints/domain/entities/task.dart';

class TaskDto {
  final String id;
  // final String backlogId;
  final List<String> usersIds;
  final String status;
  final String sprintId;
  final String? description;
  final String type;
  final String? priority;

  TaskDto(
      {required this.id,
      // required this.backlogId,
      required this.usersIds,
      required this.status,
      required this.sprintId,
      required this.description,
      required this.type,
      required this.priority});

  factory TaskDto.fromJson(Map<String, dynamic> json) => TaskDto(
      id: json['\$id'],
      // backlogId: json['backlogId'],
      usersIds: List.castFrom(json['usersIds']),
      status: json['status'],
      sprintId: json['sprintId'],
      description: json['description'],
      type: json['type'],
      priority: json['priority']);

  factory TaskDto.fromDomain(Task task) => TaskDto(
      id: task.id,
      //  backlogId: task.backlogId,
      usersIds: task.usersIds,
      status: task.status,
      sprintId: task.sprintId,
      description: task.description,
      type: task.type,
      priority: task.priority);

  Task toDomain() => Task(
      id: id,
      //backlogId: backlogId,
      usersIds: usersIds,
      status: status,
      sprintId: sprintId,
      description: description,
      type: type,
      priority: priority);

  Map<String, dynamic> toJson() => {
        // "backlogId": backlogId,
        "usersIds": usersIds,
        "status": status,
        "sprintId": sprintId
      };
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
