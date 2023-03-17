import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:scrumit/core/errors/failures.dart';
import 'package:scrumit/core/usecases/usercase.dart';
import 'package:scrumit/domain/contracts/projects/project_contract.dart';
import 'package:scrumit/domain/entities/projects/project.dart';

class Params extends Equatable {
  final Project project;
  final String projectId;

  const Params(this.project, this.projectId);

  @override
  List<Object?> get props => [project, projectId];
}

class CreateProject implements UseCase<Project, Params> {
  final ProjectContract projectContract;
  CreateProject(this.projectContract);

  @override
  Future<Either<Failure, Project>> call({required params}) async {
    return await projectContract.createProject(project: params.project);
  }
}

class GetProject implements UseCase<Project, Params> {
  final ProjectContract projectContract;
  GetProject(this.projectContract);
  @override
  Future<Either<Failure, Project>> call({required params}) async {
    return await projectContract.getProject(projectId: params.projectId);
  }
}

class GetProjectList implements UseCase<List<Project>, NoParams> {
  final ProjectContract projectContract;

  GetProjectList(this.projectContract);

  @override
  Future<Either<Failure, List<Project>>> call(
      {required NoParams params}) async {
    return await projectContract.getProjectsList();
  }
}
