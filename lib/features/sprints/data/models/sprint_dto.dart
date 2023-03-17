import 'package:scrumit/features/sprints/domain/entities/sprint.dart';

class SprintDto {
  final String id;
  final String projecId;
  final int sprintNum;
  final DateTime startingDate;
  final DateTime endDate;
  final String status;
  final String? sprintPlanning;
  final String? sprintReview;
  final String? retrospective;
  final List<dynamic> dailyScrum;
  final List<String?> tasks;

  SprintDto(
      {required this.id,
      required this.projecId,
      required this.sprintNum,
      required this.startingDate,
      required this.endDate,
      required this.status,
      this.sprintPlanning,
      this.sprintReview,
      this.retrospective,
      required this.dailyScrum,
      required this.tasks});

  factory SprintDto.fromJson(Map<String, dynamic> json) => SprintDto(
      id: json['\$id'],
      projecId: json['projecId'],
      sprintNum: json['sprintNum'],
      startingDate: DateTime.parse(json['startingDate']),
      endDate: DateTime.parse(json['endDate']),
      status: json['status'],
      dailyScrum: json['dailyScrum'] == ['null'] ? [] : json['dailyScrum'],
      tasks: [], //json['tasks'] == ['null'] ? [] : json['tasks'],
      sprintPlanning: json['sprintPlanning'],
      sprintReview: json['sprintReview'],
      retrospective: json['retrospective']);
  factory SprintDto.fromDomain(Sprint sprint) => SprintDto(
      id: sprint.id,
      projecId: sprint.projecId,
      sprintNum: sprint.sprintNum,
      startingDate: sprint.startingDate,
      endDate: sprint.endDate,
      status: sprint.status,
      dailyScrum: sprint.dailyScrum,
      tasks: sprint.tasks,
      sprintPlanning: sprint.sprintPlanning,
      sprintReview: sprint.sprintReview,
      retrospective: sprint.retrospective);

  Sprint toDomain() => Sprint(
      id: id,
      projecId: projecId,
      sprintNum: sprintNum,
      startingDate: startingDate,
      endDate: endDate,
      status: status,
      dailyScrum: dailyScrum,
      tasks: tasks,
      sprintPlanning: sprintPlanning,
      sprintReview: sprintReview,
      retrospective: retrospective);

  Map<String, dynamic> toJson() => {
        "projecId": projecId,
        "sprintNum": sprintNum,
        "startingDate": startingDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "status": status,
        "dailyScrum": dailyScrum,
        "tasks": tasks,
        "sprintPlanning": sprintPlanning,
        "sprintReview": sprintReview,
        "retrospective": retrospective
      };

  @override
  String toString() {
    return '''
              final String $id;
              final String $projecId;
              final int $sprintNum;
              final DateTime $startingDate;
              final DateTime $endDate;
              final String $status;
              final String? $sprintPlanning;
              final String? $sprintReview;
              final String? $retrospective;
              final List<dynamic>? $dailyScrum;
              final List<String?> $tasks;
                ''';
  }
}
