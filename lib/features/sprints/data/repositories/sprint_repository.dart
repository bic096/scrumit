import 'package:fpdart/fpdart.dart';
import 'package:scrumit/core/errors/exceptions.dart';
import 'package:scrumit/core/errors/failures.dart';
import 'package:scrumit/features/sprints/data/datasources/sprints_remote_data_source.dart';
import 'package:scrumit/features/sprints/domain/contracts/sprints_contract.dart';
import 'package:scrumit/features/sprints/domain/entities/sprint.dart';
import 'package:scrumit/features/sprints/domain/entities/task.dart'
    as task_entity;

class SprintRepository implements SprintContract {
  final SprintRemoteDataSourceContract sourceContract;
  SprintRepository(this.sourceContract);
  @override
  Future<Either<Failure, Sprint>> createSprint(
      String projectId, Sprint sprint) async {
    try {
      final remote = await sourceContract.createSprint(projectId, sprint);
      return Right(remote.toDomain());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Sprint>> getSprintDetails(String sprintId) async {
    try {
      final remote = await sourceContract.getSprintDetails(sprintId);
      return Right(remote.toDomain());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Sprint>>> getSprintList(String projectId) async {
    try {
      final remote = await sourceContract.getSprintList(projectId);
      List<Sprint> list = [];
      for (var item in remote) {
        list.add(item.toDomain());
      }
      return Right(list);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, task_entity.Task>> getTaskDetails(
      String taskId) async {
    try {
      final remote = await sourceContract.getTaskDetails(taskId);
      return Right(remote.toDomain());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<task_entity.Task>>> getTaskList(
      String sprintId) async {
    try {
      final remote = await sourceContract.getTaskList(sprintId);
      List<task_entity.Task> list = [];
      for (var item in remote) {
        list.add(item.toDomain());
      }
      return Right(list);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Sprint>> updateSprint(
      String sprintId, Sprint sprint) async {
    try {
      final remote = await sourceContract.updateSprint(sprintId, sprint);
      return Right(remote.toDomain());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, task_entity.Task>> updateTask(
      String taskId, task_entity.Task task) async {
    try {
      final remote = await sourceContract.updateTask(taskId, task);
      return Right(remote.toDomain());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, task_entity.Task>> createTask(
      String sprintId, task_entity.Task task) async {
    try {
      final remote = await sourceContract.createTask(sprintId, task);
      return Right(remote.toDomain());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
