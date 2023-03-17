import 'dart:convert';
import 'package:scrumit/features/projects/domain/entities/product_backlog.dart';

ProductBacklogModel productBacklogModelFromJson(String str) =>
    ProductBacklogModel.fromJson(json.decode(str));

String productBacklogModelToJson(ProductBacklogModel data) =>
    json.encode(data.toJson());

class ProductBacklogModel {
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
  //  id
  //   collectionId
  //   databaseId
  ProductBacklogModel(
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
      required this.type});
  //  : super(
  //           name: name,
  //           projectId: projectId,
  //           createdAt: createdAt,
  //           startDate: startDate,
  //           endDate: endDate,
  //           description: description,
  //           projectId: projectId);

  factory ProductBacklogModel.fromJson(Map<String, dynamic> json) =>
      ProductBacklogModel(
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
          priority: json["priority"],
          type: json['type']);

  factory ProductBacklogModel.fromDomain(ProductBacklog productBacklog) {
    return ProductBacklogModel(
        name: productBacklog.name,
        description: productBacklog.description,
        projectId: productBacklog.projectId,
        priority: productBacklog.priority,
        type: productBacklog.type);
  }
  ProductBacklog toDoamain() => ProductBacklog(
      name: name,
      id: $id!,
      projectId: projectId,
      createdAt: DateTime.parse($createdAt!),
      description: description,
      priority: priority,
      type: type);

  Map<String, dynamic> toJson() => {
        "name": name,
        "projectId": projectId,
        "description": description,
        "priority": priority,
        "type": type
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
