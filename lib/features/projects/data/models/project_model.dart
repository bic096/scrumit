import 'dart:convert';

import 'package:scrumit/features/projects/domain/entities/project.dart';

ProjectModel projectModelFromJson(String str) =>
    ProjectModel.fromJson(json.decode(str));

String projectModelToJson(ProjectModel data) => json.encode(data.toJson());

class ProjectModel {
  String? $id;
  String? $collectionId;
  String? $databaseId;
  String? $createdAt;
  String? $updatedAt;
  List<dynamic>? $permissions;

  final String projectName;
  final String ownerId;
  final String startDate;
  final String endDate;
  final String description;
  final String teamId;
  //  id
  //   collectionId
  //   databaseId
  ProjectModel(
      {this.$collectionId,
      this.$createdAt,
      this.$databaseId,
      this.$id,
      this.$permissions,
      this.$updatedAt,
      /////////////////////////
      required this.projectName,
      required this.ownerId,
      required this.startDate,
      required this.endDate,
      required this.description,
      required this.teamId});
  //  : super(
  //           projectName: projectName,
  //           projectId: projectId,
  //           createdAt: createdAt,
  //           startDate: startDate,
  //           endDate: endDate,
  //           description: description,
  //           ownerId: ownerId);

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        $databaseId: json["\$databaseId"],
        $id: json["\$id"],
        $permissions: json["\$permissions"],
        $updatedAt: json["\$updatedAt"],
        $collectionId: json["\$collectionId"],
        $createdAt: json["\$createdAt"],
        /////////////////////////////////
        ///
        ////////////////////////////////
        projectName: json["projectName"],
        ownerId: json["ownerId"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        description: json["description"],
        teamId: json["teamId"] ?? 'null',
      );

  factory ProjectModel.fromDomain(Project project) {
    return ProjectModel(
        projectName: project.projectName,
        startDate: project.startDate.toIso8601String(),
        endDate: project.endDate.toIso8601String(),
        description: project.description,
        ownerId: project.ownerId,
        teamId: project.teamId);
  }
  Project toDoamain() => Project(
      projectName: projectName,
      projectId: $id!,
      ownerId: ownerId,
      createdAt: DateTime.tryParse($createdAt!),
      startDate: DateTime.parse(startDate),
      endDate: DateTime.parse(endDate),
      description: description,
      teamId: teamId);

  Map<String, dynamic> toJson() => {
        "projectName": projectName,
        "ownerId": ownerId,
        "startDate": startDate,
        "endDate": endDate,
        "description": description,
      };

  @override
  String toString() {
    return '''
        projectId: ${$id}
        collectionId: ${$collectionId}
        databaseId: ${$databaseId}
        updatedAt: ${$updatedAt}
        permissions: ${$permissions}
        projectName: $projectName
        ownerId: $ownerId
        description: $description      
        createdAt: ${$createdAt}
        startDate: $startDate
        endDate: $endDate
        teamId: $teamId
''';
  }
}
