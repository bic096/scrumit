import 'package:fpdart/fpdart.dart';
import 'package:scrumit/core/errors/failures.dart';
import 'package:scrumit/features/projects/domain/entities/product_backlog.dart';

import 'package:scrumit/features/projects/domain/entities/project.dart';
import 'package:scrumit/features/projects/domain/entities/release_backlog.dart';

abstract class ProjectContract {
  // Future<Either<Failure, List<Project>>> getProjectsList(
  //     {required String ownerId});
  Future<Either<Failure, List<Project>>> getProjectsList(
      {required List<String> teamIds});
  Future<Either<Failure, Project>> getProject({required String projectId});
  Future<Either<Failure, Project>> createProject({required Project project});
  Future<Either<Failure, Project>> updateProject(
      {required Project project, required String projectId});

  Future<Either<Failure, List<ProductBacklog>>> getProductBacklogsList(
      {required String projectId});
  Future<Either<Failure, ProductBacklog>> getProductBacklog(
      {required String id});
  Future<Either<Failure, ProductBacklog>> createProductBacklog(
      {required ProductBacklog productBacklog});
  Future<Either<Failure, ProductBacklog>> updateProductBacklog(
      {required ProductBacklog productBacklog, required String id});

  Future<Either<Failure, List<ReleaseBacklog>>> getReleaseBacklogsList(
      {required String projectId});
  Future<Either<Failure, ReleaseBacklog>> getReleaseBacklog(
      {required String id});
  Future<Either<Failure, ReleaseBacklog>> createReleaseBacklog(
      {required ReleaseBacklog releaseBacklog});

  Future<Either<Failure, ReleaseBacklog>> updateReleaseBacklog(
      {required ReleaseBacklog releaseBacklog, required String id});
}
