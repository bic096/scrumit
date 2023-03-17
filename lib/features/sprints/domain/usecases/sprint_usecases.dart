import 'package:fpdart/fpdart.dart';
import 'package:scrumit/core/errors/failures.dart';
import 'package:scrumit/core/usecases/usercase.dart';
import 'package:scrumit/features/sprints/domain/contracts/sprints_contract.dart';
import 'package:scrumit/features/sprints/domain/entities/sprint.dart';
import 'package:scrumit/features/sprints/domain/entities/task.dart'
    as task_entity;

class Params {
  final String? projectId;
  final String? sprintId;
  final Sprint? sprint;
  final String? taskId;
  final task_entity.Task? task;

  Params({this.projectId, this.sprintId, this.sprint, this.taskId, this.task});
}

class CreateSprint implements UseCase<Sprint, Params> {
  final SprintContract sprintContract;
  CreateSprint(this.sprintContract);
  @override
  Future<Either<Failure, Sprint>> call({required Params params}) async {
    return await sprintContract.createSprint(params.projectId!, params.sprint!);
  }
}

class GetSprintsList implements UseCase<List<Sprint>, Params> {
  final SprintContract sprintContract;
  GetSprintsList(this.sprintContract);
  @override
  Future<Either<Failure, List<Sprint>>> call({required Params params}) async {
    return await sprintContract.getSprintList(params.projectId!);
  }
}

class UpdateSprint implements UseCase<Sprint, Params> {
  final SprintContract sprintContract;
  UpdateSprint(this.sprintContract);
  @override
  Future<Either<Failure, Sprint>> call({required Params params}) async {
    return await sprintContract.updateSprint(params.sprintId!, params.sprint!);
  }
}

class GetSprintDetails implements UseCase<Sprint, Params> {
  final SprintContract sprintContract;
  GetSprintDetails(this.sprintContract);
  @override
  Future<Either<Failure, Sprint>> call({required Params params}) async {
    return await sprintContract.getSprintDetails(params.sprintId!);
  }
}

class GetTaslsList implements UseCase<List<task_entity.Task>, Params> {
  final SprintContract sprintContract;
  GetTaslsList(this.sprintContract);
  @override
  Future<Either<Failure, List<task_entity.Task>>> call(
      {required Params params}) async {
    return await sprintContract.getTaskList(params.sprintId!);
  }
}

class GetTaslDetails implements UseCase<task_entity.Task, Params> {
  final SprintContract sprintContract;
  GetTaslDetails(this.sprintContract);
  @override
  Future<Either<Failure, task_entity.Task>> call(
      {required Params params}) async {
    return await sprintContract.getTaskDetails(params.taskId!);
  }
}

class CreateTask implements UseCase<task_entity.Task, Params> {
  final SprintContract sprintContract;
  CreateTask(this.sprintContract);
  @override
  Future<Either<Failure, task_entity.Task>> call(
      {required Params params}) async {
    return await sprintContract.createTask(params.sprintId!, params.task!);
  }
}

class UpdateTask implements UseCase<task_entity.Task, Params> {
  final SprintContract sprintContract;
  UpdateTask(this.sprintContract);
  @override
  Future<Either<Failure, task_entity.Task>> call(
      {required Params params}) async {
    return await sprintContract.updateTask(params.taskId!, params.task!);
  }
}
