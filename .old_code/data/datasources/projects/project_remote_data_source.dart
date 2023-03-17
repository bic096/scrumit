// import 'package:scrumit/data/models/projects/product_backlog_model.dart';
// import 'package:scrumit/data/models/projects/release_backlog_model.dart';

import 'package:flutter/foundation.dart';
import 'package:scrumit/core/datasource/appwrite.dart';
import 'package:scrumit/core/errors/exceptions.dart';
import 'package:scrumit/data/models/projects/project_model.dart';
import 'package:appwrite/appwrite.dart';
import 'package:scrumit/domain/entities/projects/project.dart';

abstract class ProjectRemoteDataSourceContract {
  ///
  /// Throws a [ServerException] for all error codes.
  Future<ProjectModel> createProject({required Project project});
  Future<ProjectModel> getProject({required String projectId});
  Future<List<ProjectModel>> getProjectsList();
}

class ProjectRemoteDataSource implements ProjectRemoteDataSourceContract {
  AppWrite appWrite = AppWrite();
  @override
  Future<ProjectModel> createProject({required Project project}) async {
    try {
      final response = await appWrite.getDataBase().createDocument(
          databaseId: '63ac50b589b991c9dedd',
          collectionId: '63ac50fb7a0929bffd77',
          documentId: ID.unique(),
          data: ProjectModel.fromDomain(project).toJson());
      //(project as ProjectModel).toJson());

      return ProjectModel.fromJson(response.data);
    } on AppwriteException catch (e) {
      debugPrint('appwrite \n $e');
      throw ServerException();
    } catch (e) {
      debugPrint(e.toString());
      throw ServerException();
    }
  }

  @override
  Future<ProjectModel> getProject({required String projectId}) async {
    try {
      final res = await appWrite.getDataBase().getDocument(
          databaseId: '63ac50b589b991c9dedd',
          collectionId: '63ac50fb7a0929bffd77',
          documentId: projectId);
      return ProjectModel.fromJson(res.data);
    } on AppwriteException catch (e) {
      debugPrint('appwrite \n $e');
      throw ServerException();
    } catch (e) {
      debugPrint(e.toString());
      throw ServerException();
    }
  }

  @override
  Future<List<ProjectModel>> getProjectsList() async {
    try {
      final res = await appWrite.getDataBase().listDocuments(
          databaseId: '63ac50b589b991c9dedd',
          collectionId: '63ac50b589b991c9dedd',
          //TODO: implement get user project list
          queries: [Query.equal('ownerId', '1')]);
      List<ProjectModel> projectslist = [];
      for (var element in res.documents) {
        projectslist.add(ProjectModel.fromJson(element.data));
      }
      return projectslist;
    } on AppwriteException catch (e) {
      debugPrint('appwrite \n $e');
      throw ServerException();
    } catch (e) {
      debugPrint(e.toString());
      throw ServerException();
    }
  }
}

// import 'package:appwrite/appwrite.dart';

// void main() { // Init SDK
//   Client client = Client();
//   Databases databases = Databases(client);

//   client
//     .setEndpoint('https://[HOSTNAME_OR_IP]/v1') // Your API Endpoint
//     .setProject('5df5acd0d48c2') // Your project ID
//   ;
//   Future result = databases.createDocument(
//     databaseId: '[DATABASE_ID]',
//     collectionId: '[COLLECTION_ID]',
//     documentId: '[DOCUMENT_ID]',
//     data: {},
//   );

//   result
//     .then((response) {
//       print(response);
//     }).catchError((error) {
//       print(error.response);
//   });
// }