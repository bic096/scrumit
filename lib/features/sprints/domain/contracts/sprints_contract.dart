import 'package:fpdart/fpdart.dart';
import 'package:scrumit/core/errors/failures.dart';
import 'package:scrumit/features/sprints/domain/entities/sprint.dart';
import 'package:scrumit/features/sprints/domain/entities/task.dart'
    as task_entity;

abstract class SprintContract {
  Future<Either<Failure, List<Sprint>>> getSprintList(String projectId);
  Future<Either<Failure, Sprint>> getSprintDetails(String sprintId);
  Future<Either<Failure, Sprint>> createSprint(String projectId, Sprint sprint);
  Future<Either<Failure, Sprint>> updateSprint(String sprintId, Sprint sprint);

  //tasks
  Future<Either<Failure, List<task_entity.Task>>> getTaskList(String sprintId);
  Future<Either<Failure, task_entity.Task>> getTaskDetails(String taskId);
  Future<Either<Failure, task_entity.Task>> updateTask(
      String taskId, task_entity.Task task);
  Future<Either<Failure, task_entity.Task>> createTask(
      String sprintId, task_entity.Task task);
}
