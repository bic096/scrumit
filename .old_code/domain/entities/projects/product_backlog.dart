class ProductBacklog {
  final String id;
  final String projectId;
  final String? name;
  final String? description;
  final double priority;

  ProductBacklog({
    required this.id,
    required this.projectId,
    this.name,
    this.description,
    required this.priority,
  });
}
