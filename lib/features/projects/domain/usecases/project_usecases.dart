import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:scrumit/core/errors/failures.dart';
import 'package:scrumit/core/usecases/usercase.dart';

import 'package:scrumit/features/projects/domain/contracts/project_contract.dart';
import 'package:scrumit/features/projects/domain/entities/product_backlog.dart';
import 'package:scrumit/features/projects/domain/entities/project.dart';
import 'package:scrumit/features/projects/domain/entities/release_backlog.dart';

class Params extends Equatable {
  final Project? project;
  final String? projectId;
  final String? ownerId;
  final ProductBacklog? productBacklog;
  final String? productBacklogId;
  final ReleaseBacklog? releaseBacklog;
  final String? releaseBacklogId;
  final List<String>? teamIds;

  const Params(
      {this.project,
      this.projectId,
      this.ownerId,
      this.productBacklogId,
      this.productBacklog,
      this.releaseBacklog,
      this.releaseBacklogId,
      this.teamIds});

  @override
  List<Object?> get props => [project, projectId, ownerId];
}

class CreateProject implements UseCase<Project, Params> {
  final ProjectContract projectContract;
  CreateProject(this.projectContract);

  @override
  Future<Either<Failure, Project>> call({required params}) async {
    return await projectContract.createProject(project: params.project!);
  }
}

class GetProject implements UseCase<Project, Params> {
  final ProjectContract projectContract;
  GetProject(this.projectContract);
  @override
  Future<Either<Failure, Project>> call({required params}) async {
    return await projectContract.getProject(projectId: params.projectId!);
  }
}

class GetProjectList implements UseCase<List<Project>, Params> {
  final ProjectContract projectContract;

  GetProjectList(this.projectContract);

  @override
  Future<Either<Failure, List<Project>>> call({required Params params}) async {
    return await projectContract.getProjectsList(teamIds: params.teamIds!);
  }
}

class UpdateProject implements UseCase<Project, Params> {
  final ProjectContract projectContract;
  UpdateProject(this.projectContract);

  @override
  Future<Either<Failure, Project>> call({required Params params}) async {
    return await projectContract.updateProject(
        project: params.project!, projectId: params.projectId!);
  }
}

class CreateProductBacklog implements UseCase<ProductBacklog, Params> {
  final ProjectContract projectContract;
  CreateProductBacklog(this.projectContract);

  @override
  Future<Either<Failure, ProductBacklog>> call({required Params params}) async {
    return await projectContract.createProductBacklog(
        productBacklog: params.productBacklog!);
  }
}

class GetProductBacklog implements UseCase<ProductBacklog, Params> {
  final ProjectContract projectContract;
  GetProductBacklog(this.projectContract);

  @override
  Future<Either<Failure, ProductBacklog>> call({required Params params}) async {
    return await projectContract.getProductBacklog(
        id: params.productBacklogId!);
  }
}

class GetProductBacklogList implements UseCase<List<ProductBacklog>, Params> {
  final ProjectContract projectContract;
  GetProductBacklogList(this.projectContract);

  @override
  Future<Either<Failure, List<ProductBacklog>>> call(
      {required Params params}) async {
    return await projectContract.getProductBacklogsList(
        projectId: params.projectId!);
  }
}

class UpdateProductBacklog implements UseCase<ProductBacklog, Params> {
  final ProjectContract projectContract;
  UpdateProductBacklog(this.projectContract);

  @override
  Future<Either<Failure, ProductBacklog>> call({required Params params}) async {
    return await projectContract.updateProductBacklog(
        productBacklog: params.productBacklog!, id: params.productBacklogId!);
  }
}

class CreateReleaseBacklog implements UseCase<ReleaseBacklog, Params> {
  final ProjectContract projectContract;
  CreateReleaseBacklog(this.projectContract);
  @override
  Future<Either<Failure, ReleaseBacklog>> call({required Params params}) async {
    return await projectContract.createReleaseBacklog(
        releaseBacklog: params.releaseBacklog!);
  }
}

class GetReleaseBacklog implements UseCase<ReleaseBacklog, Params> {
  final ProjectContract projectContract;
  GetReleaseBacklog(this.projectContract);
  @override
  Future<Either<Failure, ReleaseBacklog>> call({required Params params}) async {
    return await projectContract.getReleaseBacklog(
        id: params.releaseBacklogId!);
  }
}

class GetReleaseBacklogList implements UseCase<List<ReleaseBacklog>, Params> {
  final ProjectContract projectContract;

  GetReleaseBacklogList(this.projectContract);
  @override
  Future<Either<Failure, List<ReleaseBacklog>>> call(
      {required Params params}) async {
    return await projectContract.getReleaseBacklogsList(
        projectId: params.projectId!);
  }
}

class UpdateReleaseBacklog implements UseCase<ReleaseBacklog, Params> {
  final ProjectContract projectContract;

  UpdateReleaseBacklog(this.projectContract);
  @override
  Future<Either<Failure, ReleaseBacklog>> call({required Params params}) async {
    return await projectContract.updateReleaseBacklog(
        releaseBacklog: params.releaseBacklog!, id: params.releaseBacklogId!);
  }
}
