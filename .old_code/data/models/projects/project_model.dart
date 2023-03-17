import 'dart:convert';
import 'package:scrumit/domain/entities/projects/project.dart';

ProjectModel projectModelFromJson(String str) =>
    ProjectModel.fromJson(json.decode(str));

String projectModelToJson(ProjectModel data) => json.encode(data.toJson());

class ProjectModel {
  String? $documentId;
  String? $collectionId;
  String? $databaseId;
  DateTime? $createdAt;
  DateTime? $updatedAt;
  List<String>? $permissions;

  final String projectName;
  final String ownerId;
  final DateTime startDate;
  final DateTime endDate;
  final String description;
  //  id
  //   collectionId
  //   databaseId
  ProjectModel({
    this.$collectionId,
    this.$createdAt,
    this.$databaseId,
    this.$documentId,
    this.$permissions,
    this.$updatedAt,
    /////////////////////////
    required this.projectName,
    required this.ownerId,
    required this.startDate,
    required this.endDate,
    required this.description,
  });
  //  : super(
  //           projectName: projectName,
  //           projectId: projectId,
  //           createdAt: createdAt,
  //           startDate: startDate,
  //           endDate: endDate,
  //           description: description,
  //           ownerId: ownerId);

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        $databaseId: json["\$databaseId"], $documentId: json["\$documentId"],
        $permissions: json["\$permissions"], $updatedAt: json["\$updatedAt"],
        $collectionId: json["\$collectionId"],
        $createdAt: json["\$createdAt"],
        /////////////////////////////////
        ///
        ////////////////////////////////
        projectName: json["data"]["projectName"],
        ownerId: json["data"]["ownerId"],
        startDate: json["data"]["startDate"],
        endDate: json["data"]["endDate"],
        description: json["data"]["description"],
      );

  factory ProjectModel.fromDomain(Project project) {
    return ProjectModel(
        projectName: project.projectName,
        startDate: project.startDate,
        endDate: project.endDate,
        description: project.description,
        ownerId: project.ownerId);
  }
  Project toDoamain() => Project(
      projectName: projectName,
      projectId: $documentId!,
      ownerId: ownerId,
      createdAt: $createdAt!,
      startDate: startDate,
      endDate: endDate,
      description: description);

  Map<String, dynamic> toJson() => {
        "projectName": projectName,
        "ownerId": ownerId,
        "startDate": startDate,
        "endDate": endDate,
        "description": description,
      };
}
