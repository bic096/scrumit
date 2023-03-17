import 'dart:convert';
import 'package:scrumit/features/projects/domain/entities/release_backlog.dart';

ReleaseBacklogModel releaseBacklogModelFromJson(String str) =>
    ReleaseBacklogModel.fromJson(json.decode(str));

String releaseBacklogModelToJson(ReleaseBacklogModel data) =>
    json.encode(data.toJson());

class ReleaseBacklogModel {
  String? $id;
  String? $collectionId;
  String? $databaseId;
  String? $createdAt;
  String? $updatedAt;
  List<dynamic>? $permissions;

  final String name;
  final String projectId;
  final String description;
  final String priority;
  final String type;
  final String? sprintId;
  //  id
  //   collectionId
  //   databaseId
  ReleaseBacklogModel(
      {this.$collectionId,
      this.$createdAt,
      this.$databaseId,
      this.$id,
      this.$permissions,
      this.$updatedAt,
      /////////////////////////
      required this.name,
      required this.projectId,
      required this.description,
      required this.priority,
      required this.type,
      this.sprintId});
  //  : super(
  //           name: name,
  //           projectId: projectId,
  //           createdAt: createdAt,
  //           startDate: startDate,
  //           endDate: endDate,
  //           description: description,
  //           projectId: projectId);

  factory ReleaseBacklogModel.fromJson(Map<String, dynamic> json) =>
      ReleaseBacklogModel(
          $databaseId: json["\$databaseId"],
          $id: json["\$id"],
          $permissions: json["\$permissions"],
          $updatedAt: json["\$updatedAt"],
          $collectionId: json["\$collectionId"],
          $createdAt: json["\$createdAt"],
          /////////////////////////////////
          ///
          ////////////////////////////////
          name: json["name"],
          projectId: json["projectId"],
          description: json["description"],
          priority: json["priority"].toString(),
          type: json['type'],
          sprintId: json['sprintId']);

  factory ReleaseBacklogModel.fromDomain(ReleaseBacklog releaseBacklog) {
    return ReleaseBacklogModel(
        name: releaseBacklog.name,
        description: releaseBacklog.description,
        projectId: releaseBacklog.projectId,
        priority: releaseBacklog.priority,
        type: releaseBacklog.type,
        sprintId: releaseBacklog.sprintId);
  }
  ReleaseBacklog toDoamain() => ReleaseBacklog(
      name: name,
      id: $id!,
      projectId: projectId,
      createdAt: DateTime.parse($createdAt!),
      description: description,
      priority: priority,
      type: type,
      sprintId: sprintId);

  Map<String, dynamic> toJson() => {
        "name": name,
        "projectId": projectId,
        "description": description,
        "priority": priority,
        "type": type,
        "sprintId": sprintId
      };

  @override
  String toString() {
    return '''
        projectId: ${$id}
        collectionId: ${$collectionId}
        databaseId: ${$databaseId}
        updatedAt: ${$updatedAt}
        permissions: ${$permissions}
        name: $name
        projectId: $projectId
        description: $description      
        createdAt: ${$createdAt}
        "priority": $priority
''';
  }
}
