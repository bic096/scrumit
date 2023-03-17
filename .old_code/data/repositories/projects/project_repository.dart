import 'package:fpdart/fpdart.dart';
import 'package:scrumit/core/errors/exceptions.dart';
import 'package:scrumit/core/errors/failures.dart';
import 'package:scrumit/data/datasources/projects/project_remote_data_source.dart';
import 'package:scrumit/domain/contracts/projects/project_contract.dart';
import 'package:scrumit/domain/entities/projects/release_backlog.dart';
import 'package:scrumit/domain/entities/projects/project.dart';
import 'package:scrumit/domain/entities/projects/product_backlog.dart';

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
  Future<Either<Failure, List<Project>>> getProjectsList() async {
    try {
      final remoteProject =
          await projectRemoteDataSourceContract.getProjectsList();
      List<Project> projectslist = [];
      for (var element in remoteProject) {
        projectslist.add(element.toDoamain());
      }
      return Right(projectslist);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ProductBacklog>> createProductBacklog(
      {required ProductBacklog productBacklog}) {
    // TODO: implement createProductBacklog
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ReleaseBacklog>> createReleaseBacklog(
      {required ProductBacklog productBacklog}) {
    // TODO: implement createReleaseBacklog
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ProductBacklog>> getProductBacklog(
      {required String id}) {
    // TODO: implement getProductBacklog
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ProductBacklog>>> getProductBacklogsList(
      {required String projectId}) {
    // TODO: implement getProductBacklogsList
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ReleaseBacklog>> getReleaseBacklog(
      {required String id}) {
    // TODO: implement getReleaseBacklog
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ReleaseBacklog>>> getReleaseBacklogsList(
      {required String projectId}) {
    // TODO: implement getReleaseBacklogsList
    throw UnimplementedError();
  }
}
