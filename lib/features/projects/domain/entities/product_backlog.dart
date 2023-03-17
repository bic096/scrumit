import 'package:scrumit/core/presentaion/values.dart';

class ProductBacklog {
  final String id;
  final String projectId;
  final String name;
  final String description;
  final String priority;
  final DateTime createdAt;
  final String type;

  ProductBacklog(
      {required this.id,
      required this.projectId,
      required this.name,
      required this.description,
      required this.priority,
      required this.createdAt,
      required this.type});
  ProductBacklog copyWith(
      {String? name, String? description, String? priority, String? type}) {
    return ProductBacklog(
        projectId: projectId,
        name: name ?? this.name,
        description: description ?? this.description,
        priority: priority ?? this.priority,
        createdAt: createdAt,
        type: type ?? this.type,
        id: id);
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
