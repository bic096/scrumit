import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'package:scrumit/core/datasource/appwrite.dart';
import 'package:scrumit/core/errors/exceptions.dart';
import 'package:scrumit/features/sprints/data/models/sprint_dto.dart';
import 'package:scrumit/features/sprints/data/models/task_dto.dart';
import 'package:scrumit/features/sprints/domain/entities/sprint.dart';
import 'package:scrumit/features/sprints/domain/entities/task.dart';
import 'package:scrumit/core/constant.dart' as consts;

enum Type { task, story, release }

abstract class SprintRemoteDataSourceContract {
  Future<List<SprintDto>> getSprintList(String projectId);
  Future<SprintDto> getSprintDetails(String sprintId);
  Future<SprintDto> createSprint(String projectId, Sprint sprint);
  Future<SprintDto> updateSprint(String sprintId, Sprint sprint);

  //tasks
  Future<List<TaskDto>> getTaskList(String sprintId);
  Future<TaskDto> getTaskDetails(String taskId);
  Future<TaskDto> updateTask(String taskId, Task task);
  Future<TaskDto> createTask(String sprintId, Task task);
}

class SprintRemoteDataSource implements SprintRemoteDataSourceContract {
  final AppWrite appWrite;
  SprintRemoteDataSource(this.appWrite);

  @override
  Future<SprintDto> createSprint(String projectId, Sprint sprint) async {
    try {
      final res = await appWrite.getDataBase().createDocument(
          databaseId: consts.kScrumitDatabaseId,
          collectionId: consts.kSprintCollectionId,
          documentId: ID.unique(),
          data: SprintDto.fromDomain(sprint).toJson());

      debugPrint(res.toMap.toString());
      return SprintDto.fromJson(res.data);
    } on AppwriteException catch (e) {
      debugPrint('appwrite Excepton');
      debugPrint(e.toString());
      throw ServerException();
    } catch (e) {
      debugPrint('anther Excepton');
      debugPrint(e.toString());
      throw ServerException();
    }
  }

  @override
  Future<SprintDto> getSprintDetails(String sprintId) async {
    try {
      final res = await appWrite.getDataBase().getDocument(
          databaseId: consts.kScrumitDatabaseId,
          collectionId: consts.kSprintCollectionId,
          documentId: sprintId);
      debugPrint(res.toMap.toString());
      return SprintDto.fromJson(res.data);
    } on AppwriteException catch (e) {
      debugPrint('appwrite Excepton');
      debugPrint(e.toString());
      throw ServerException();
    } catch (e) {
      debugPrint('anther Excepton');
      debugPrint(e.toString());
      throw ServerException();
    }
  }

  @override
  Future<List<SprintDto>> getSprintList(String projectId) async {
    try {
      final res = await appWrite.getDataBase().listDocuments(
          databaseId: consts.kScrumitDatabaseId,
          collectionId: consts.kSprintCollectionId,
          queries: [
            Query.equal('projecId', [projectId])
          ]);
      debugPrint('${res.toMap}');
      List<SprintDto> list = [];
      for (var items in res.documents) {
        debugPrint(items.toMap().toString());
        list.add(SprintDto.fromJson(items.data));
      }
      return list;
    } on AppwriteException catch (e) {
      debugPrint('appwrite Excepton');
      debugPrint(e.toString());
      throw ServerException();
    } catch (e) {
      debugPrint('anther Excepton');
      debugPrint(e.toString());
      throw ServerException();
    }
  }

  @override
  Future<SprintDto> updateSprint(String sprintId, Sprint sprint) async {
    try {
      final res = await appWrite.getDataBase().updateDocument(
          databaseId: consts.kScrumitDatabaseId,
          collectionId: consts.kSprintCollectionId,
          documentId: sprintId,
          data: SprintDto.fromDomain(sprint).toJson());
      debugPrint('${res.data}');
      return SprintDto.fromJson(res.data);
    } on AppwriteException catch (e) {
      debugPrint('appwrite Excepton');
      debugPrint(e.toString());
      throw ServerException();
    } catch (e) {
      debugPrint('anther Excepton');
      debugPrint(e.toString());
      throw ServerException();
    }
  }

  @override
  Future<TaskDto> getTaskDetails(String taskId) async {
    try {
      final res = await appWrite.getDataBase().getDocument(
          databaseId: consts.kScrumitDatabaseId,
          collectionId: consts.kBacklogsCollectionId,
          documentId: taskId);
      debugPrint(res.toMap.toString());
      return TaskDto.fromJson(res.data);
    } on AppwriteException catch (e) {
      debugPrint('appwrite Excepton');
      debugPrint(e.toString());
      throw ServerException();
    } catch (e) {
      debugPrint('anther Excepton');
      debugPrint(e.toString());
      throw ServerException();
    }
  }

  @override
  Future<List<TaskDto>> getTaskList(String sprintId) async {
    try {
      final res = await appWrite.getDataBase().listDocuments(
          databaseId: consts.kScrumitDatabaseId,
          collectionId: consts.kBacklogsCollectionId,
          queries: [
            Query.equal('type', "task"),
            Query.equal('sprintId', sprintId)
          ]);
      debugPrint('${res.toMap()}');
      List<TaskDto> list = [];
      for (var item in res.documents) {
        list.add(TaskDto.fromJson(item.data));
      }
      return list;
    } on AppwriteException catch (e) {
      debugPrint('appwrite Excepton');
      debugPrint(e.toString());
      throw ServerException();
    } catch (e) {
      debugPrint('anther Excepton');
      debugPrint(e.toString());
      throw ServerException();
    }
  }

  @override
  Future<TaskDto> updateTask(String taskId, Task task) async {
    try {
      final res = await appWrite.getDataBase().updateDocument(
          databaseId: consts.kScrumitDatabaseId,
          collectionId: consts.kBacklogsCollectionId,
          documentId: taskId,
          data: TaskDto.fromDomain(task).toJson());
      debugPrint(res.data.toString());
      return TaskDto.fromJson(res.data);
    } on AppwriteException catch (e) {
      debugPrint('appwrite Excepton');
      debugPrint(e.toString());
      throw ServerException();
    } catch (e) {
      debugPrint('anther Excepton');
      debugPrint(e.toString());
      throw ServerException();
    }
  }

  @override
  Future<TaskDto> createTask(String sprintId, Task task) async {
    try {
      final res = await appWrite.getDataBase().createDocument(
          databaseId: consts.kScrumitDatabaseId,
          collectionId: consts.kBacklogsCollectionId,
          documentId: ID.unique(),
          data: TaskDto.fromDomain(task).toJson());

      debugPrint(res.toMap.toString());
      return TaskDto.fromJson(res.data);
    } on AppwriteException catch (e) {
      debugPrint('appwrite Excepton');
      debugPrint(e.toString());
      throw ServerException();
    } catch (e) {
      debugPrint('anther Excepton');
      debugPrint(e.toString());
      throw ServerException();
    }
  }
}
