import 'package:fpdart/fpdart.dart';
import 'package:scrumit/core/errors/failures.dart';
import 'package:scrumit/domain/entities/projects/product_backlog.dart';
import 'package:scrumit/domain/entities/projects/project.dart';
import 'package:scrumit/domain/entities/projects/release_backlog.dart';

abstract class ProjectContract {
  Future<Either<Failure, List<Project>>> getProjectsList();
  Future<Either<Failure, Project>> getProject({required String projectId});
  Future<Either<Failure, Project>> createProject({required Project project});

  Future<Either<Failure, List<ProductBacklog>>> getProductBacklogsList(
      {required String projectId});
  Future<Either<Failure, ProductBacklog>> getProductBacklog(
      {required String id});
  Future<Either<Failure, ProductBacklog>> createProductBacklog(
      {required ProductBacklog productBacklog});

  Future<Either<Failure, List<ReleaseBacklog>>> getReleaseBacklogsList(
      {required String projectId});
  Future<Either<Failure, ReleaseBacklog>> getReleaseBacklog(
      {required String id});
  Future<Either<Failure, ReleaseBacklog>> createReleaseBacklog(
      {required ProductBacklog productBacklog});
}
