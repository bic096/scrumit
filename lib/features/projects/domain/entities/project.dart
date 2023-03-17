import 'package:equatable/equatable.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class Project extends Equatable {
  const Project(
      {required this.projectName,
      this.projectId,
      required this.ownerId,
      this.createdAt,
      required this.startDate,
      required this.endDate,
      required this.description,
      required this.teamId});

  final String projectName;
  final String? projectId;
  final String ownerId;
  final DateTime? createdAt;
  final DateTime startDate;
  final DateTime endDate;
  final String description;
  final String teamId;
//TODO: impel
  // final String currentSprint;
  Project copyWith(
      {String? name,
      String? description,
      DateTime? startDate,
      DateTime? endDate,
      String? ownerId}) {
    return Project(
        projectId: projectId,
        projectName: name ?? projectName,
        description: description ?? this.description,
        startDate: startDate ?? this.startDate,
        createdAt: createdAt,
        endDate: endDate ?? this.endDate,
        ownerId: ownerId ?? this.ownerId,
        teamId: teamId);
  }

  @override
  String toString() {
    return '''
        projectId: $projectId
        projectName: $projectName
        ownerId: $ownerId
        createdAt: $createdAt
        startDate: $startDate
        endDate: $endDate
        description: $description
''';
  }

  @override
  List<Object?> get props => [
        projectId,
        projectName,
        ownerId,
        createdAt,
        startDate,
        endDate,
        description
      ];
}
