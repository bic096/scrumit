import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:scrumit/core/errors/exceptions.dart';
import 'package:scrumit/core/errors/failures.dart';
import 'package:scrumit/features/projects/data/datasources/project_remote_data_source.dart';
import 'package:scrumit/features/projects/domain/contracts/project_contract.dart';
import 'package:scrumit/features/projects/domain/entities/product_backlog.dart';
import 'package:scrumit/features/projects/domain/entities/project.dart';
import 'package:scrumit/features/projects/domain/entities/release_backlog.dart';

class ProjectRepository implements ProjectContract {
  ProjectRemoteDataSourceContract projectRemoteDataSourceContract;

  ProjectRepository({required this.projectRemoteDataSourceContract});

  @override
  Future<Either<Failure, Project>> createProject(
      {required Project project}) async {
    try {
      final remoteProject =
          await projectRemoteDataSourceContract.createProject(project: project);

      return Right(remoteProject.toDoamain());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Project>> getProject(
      {required String projectId}) async {
    try {
      final remoteProject = await projectRemoteDataSourceContract.getProject(
          projectId: projectId);

      return Right(remoteProject.toDoamain());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  // Future<Either<Failure, List<Project>>> getProjectsList(
  //     {required String ownerId}) async {
  Future<Either<Failure, List<Project>>> getProjectsList(
      {required List<String> teamIds}) async {
    try {
      final remoteProject = await projectRemoteDataSourceContract
          .getProjectsList(teamIds: teamIds);
      debugPrint(remoteProject.toString());
      List<Project> projectslist = [];
      for (var element in remoteProject) {
        debugPrint(element.toString());
        projectslist.add(element.toDoamain());
      }
      return Right(projectslist);
    } on ServerException {
      debugPrint('heeeerrr');
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Project>> updateProject(
      {required Project project, required String projectId}) async {
    try {
      final remoteProject = await projectRemoteDataSourceContract.updateProject(
          project: project, projectId: projectId);

      return Right(remoteProject.toDoamain());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ProductBacklog>> createProductBacklog(
      {required ProductBacklog productBacklog}) async {
    try {
      final remoteBacklog = await projectRemoteDataSourceContract
          .createProductBacklog(productBacklog: productBacklog);
      return Right(remoteBacklog.toDoamain());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ProductBacklog>> getProductBacklog(
      {required String id}) async {
    try {
      final remoteBacklog = await projectRemoteDataSourceContract
          .getProductBacklog(productId: id);
      return Right(remoteBacklog.toDoamain());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProductBacklog>>> getProductBacklogsList(
      {required String projectId}) async {
    try {
      final remoteBacklog = await projectRemoteDataSourceContract
          .getProductBacklogsList(projectId: projectId);
      List<ProductBacklog> productList = [];
      for (var product in remoteBacklog) {
        productList.add(product.toDoamain());
      }
      return Right(productList);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ProductBacklog>> updateProductBacklog(
      {required ProductBacklog productBacklog, required String id}) async {
    try {
      final remoteBacklog = await projectRemoteDataSourceContract
          .updateProductBacklog(productBacklog: productBacklog, id: id);
      return Right(remoteBacklog.toDoamain());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ReleaseBacklog>> createReleaseBacklog(
      {required ReleaseBacklog releaseBacklog}) async {
    try {
      final remoteBacklog = await projectRemoteDataSourceContract
          .createReleaseBacklog(releaseBacklog: releaseBacklog);
      return Right(remoteBacklog.toDoamain());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ReleaseBacklog>> getReleaseBacklog(
      {required String id}) async {
    try {
      final remoteBacklog = await projectRemoteDataSourceContract
          .getReleaseBacklog(releaseId: id);
      return Right(remoteBacklog.toDoamain());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ReleaseBacklog>>> getReleaseBacklogsList(
      {required String projectId}) async {
    try {
      final remoteBacklog = await projectRemoteDataSourceContract
          .getReleaseBacklogsList(projectId: projectId);

      List<ReleaseBacklog> releaseList = [];
      for (var release in remoteBacklog) {
        releaseList.add(release.toDoamain());
      }
      return Right(releaseList);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ReleaseBacklog>> updateReleaseBacklog(
      {required ReleaseBacklog releaseBacklog, required String id}) async {
    try {
      final remoteBacklog = await projectRemoteDataSourceContract
          .updateReleaseBacklog(releaseBacklog: releaseBacklog, id: id);
      return Right(remoteBacklog.toDoamain());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
