import 'package:flutter/foundation.dart';
import 'package:scrumit/core/constant.dart';
import 'package:scrumit/core/datasource/appwrite.dart';
import 'package:scrumit/core/errors/exceptions.dart';
import 'package:appwrite/appwrite.dart';
import 'package:scrumit/features/projects/data/models/product_backlog_model.dart';
import 'package:scrumit/features/projects/data/models/project_model.dart';
import 'package:scrumit/features/projects/data/models/release_backlog_model.dart';
import 'package:scrumit/features/projects/domain/entities/product_backlog.dart';
import 'package:scrumit/features/projects/domain/entities/project.dart';
import 'package:scrumit/features/projects/domain/entities/release_backlog.dart';

abstract class ProjectRemoteDataSourceContract {
  ///
  /// Throws a [ServerException] for all error codes.
  Future<ProjectModel> createProject({required Project project});
  Future<ProjectModel> getProject({required String projectId});
//  Future<List<ProjectModel>> getProjectsList({required String ownerId});
  Future<List<ProjectModel>> getProjectsList({required List<String> teamIds});
  Future<ProjectModel> updateProject(
      {required Project project, required String projectId});

  Future<ReleaseBacklogModel> createReleaseBacklog(
      {required ReleaseBacklog releaseBacklog});
  Future<ReleaseBacklogModel> getReleaseBacklog({required String releaseId});
  Future<List<ReleaseBacklogModel>> getReleaseBacklogsList(
      {required String projectId});
  Future<ReleaseBacklogModel> updateReleaseBacklog(
      {required ReleaseBacklog releaseBacklog, required String id});

  Future<ProductBacklogModel> createProductBacklog(
      {required ProductBacklog productBacklog});
  Future<ProductBacklogModel> getProductBacklog({required String productId});
  Future<List<ProductBacklogModel>> getProductBacklogsList(
      {required String projectId});
  Future<ProductBacklogModel> updateProductBacklog(
      {required ProductBacklog productBacklog, required String id});
}

class ProjectRemoteDataSource implements ProjectRemoteDataSourceContract {
  AppWrite appWrite;
  ProjectRemoteDataSource({required this.appWrite});
  // AppWrite appWrite = AppWrite();
  @override
  Future<ProjectModel> createProject({required Project project}) async {
    try {
      final response = await appWrite.getDataBase().createDocument(
          databaseId: kScrumitDatabaseId,
          collectionId: kProjectCollectionId,
          documentId: ID.unique(),
          data: ProjectModel.fromDomain(project).toJson());
      //(project as ProjectModel).toJson());

      return ProjectModel.fromJson(response.toMap()['data']);
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
          databaseId: kScrumitDatabaseId,
          collectionId: kProjectCollectionId,
          documentId: projectId);
      return ProjectModel.fromJson(res.toMap()['data']);
    } on AppwriteException catch (e) {
      debugPrint('appwrite \n $e');
      throw ServerException();
    } catch (e) {
      debugPrint(e.toString());
      throw ServerException();
    }
  }

  ///modification we are using teamID insted of ownerId
  @override
  // Future<List<ProjectModel>> getProjectsList({required String ownerId}) async {
  Future<List<ProjectModel>> getProjectsList(
      {required List<String> teamIds}) async {
    try {
      final res = await appWrite.getDataBase().listDocuments(
          databaseId: kScrumitDatabaseId, collectionId: kProjectCollectionId,
          //TODO: implement get user project list
          // queries: [Query.equal('ownerId', ownerId)]);
          queries: [Query.equal('teamId', teamIds)]);
      List<ProjectModel> projectslist = [];

      for (var element in res.documents) {
        debugPrint(element.toMap()['data'].toString());
        projectslist.add(ProjectModel.fromJson(element.toMap()['data']));
      }
      return projectslist;
    } on AppwriteException catch (e) {
      debugPrint('remote data source \n $e');
      throw ServerException();
    } catch (e) {
      debugPrint('remote data source \n $e');
      throw ServerException();
    }
  }

  @override
  Future<ProjectModel> updateProject(
      {required Project project, required String projectId}) async {
    try {
      final response = await appWrite.getDataBase().updateDocument(
          databaseId: kScrumitDatabaseId,
          collectionId: kProjectCollectionId,
          documentId: projectId,
          data: ProjectModel.fromDomain(project).toJson());
      return ProjectModel.fromJson(response.toMap()['data']);
    } on AppwriteException catch (e) {
      debugPrint('appwrite \n $e');
      throw ServerException();
    } catch (e) {
      debugPrint(e.toString());
      throw ServerException();
    }
  }

  @override
  Future<ProductBacklogModel> createProductBacklog(
      {required ProductBacklog productBacklog}) async {
    try {
      final response = await appWrite.getDataBase().createDocument(
          databaseId: kScrumitDatabaseId,
          collectionId: kBacklogsCollectionId,
          //collectionId: kProductBacklogCollectionId,
          documentId: ID.unique(),
          data: ProductBacklogModel.fromDomain(productBacklog).toJson());
      //(project as ProjectModel).toJson());

      return ProductBacklogModel.fromJson(response.toMap()['data']);
    } on AppwriteException catch (e) {
      debugPrint('appwrite \n $e');
      throw ServerException();
    } catch (e) {
      debugPrint(e.toString());
      throw ServerException();
    }
  }

  @override
  Future<ProductBacklogModel> getProductBacklog(
      {required String productId}) async {
    try {
      final res = await appWrite.getDataBase().getDocument(
          databaseId: kScrumitDatabaseId,
          collectionId: kBacklogsCollectionId,
          //collectionId: kProductBacklogCollectionId,
          documentId: productId);
      return ProductBacklogModel.fromJson(res.toMap()['data']);
    } on AppwriteException catch (e) {
      debugPrint('appwrite \n $e');
      throw ServerException();
    } catch (e) {
      debugPrint(e.toString());
      throw ServerException();
    }
  }

  @override
  Future<List<ProductBacklogModel>> getProductBacklogsList(
      {required String projectId}) async {
    try {
      final res = await appWrite.getDataBase().listDocuments(
          databaseId: kScrumitDatabaseId,
          collectionId: kBacklogsCollectionId,
          //collectionId: kProductBacklogCollectionId,
          //TODO: implement get user project list
          queries: [
            Query.equal('projectId', projectId),
            Query.equal('type', 'story')
          ]);
      List<ProductBacklogModel> productBackloglist = [];

      for (var element in res.documents) {
        debugPrint(element.toMap()['data'].toString());
        productBackloglist
            .add(ProductBacklogModel.fromJson(element.toMap()['data']));
      }
      return productBackloglist;
    } on AppwriteException catch (e) {
      debugPrint('remote data source \n $e');
      throw ServerException();
    } catch (e) {
      debugPrint('remote data source \n $e');
      throw ServerException();
    }
  }

  @override
  Future<ProductBacklogModel> updateProductBacklog(
      {required ProductBacklog productBacklog, required String id}) async {
    try {
      final response = await appWrite.getDataBase().updateDocument(
          databaseId: kScrumitDatabaseId,
          collectionId: kBacklogsCollectionId,
          //collectionId: kProductBacklogCollectionId,
          documentId: id,
          data: ProductBacklogModel.fromDomain(productBacklog).toJson());
      //(project as ProjectModel).toJson());

      return ProductBacklogModel.fromJson(response.toMap()['data']);
    } on AppwriteException catch (e) {
      debugPrint('appwrite \n $e');
      throw ServerException();
    } catch (e) {
      debugPrint(e.toString());
      throw ServerException();
    }
  }

  @override
  Future<ReleaseBacklogModel> createReleaseBacklog(
      {required ReleaseBacklog releaseBacklog}) async {
    try {
      final response = await appWrite.getDataBase().createDocument(
          databaseId: kScrumitDatabaseId,
          collectionId: kBacklogsCollectionId,
          //collectionId: kReleaseBacklogCollectionId,
          documentId: ID.unique(),
          data: ReleaseBacklogModel.fromDomain(releaseBacklog).toJson());
      //(project as ProjectModel).toJson());

      return ReleaseBacklogModel.fromJson(response.toMap()['data']);
    } on AppwriteException catch (e) {
      debugPrint('appwrite \n $e');
      throw ServerException();
    } catch (e) {
      debugPrint(e.toString());
      throw ServerException();
    }
  }

  @override
  Future<ReleaseBacklogModel> getReleaseBacklog(
      {required String releaseId}) async {
    try {
      final res = await appWrite.getDataBase().getDocument(
          databaseId: kScrumitDatabaseId,
          collectionId: kBacklogsCollectionId,
          //collectionId: kReleaseBacklogCollectionId,
          documentId: releaseId);
      return ReleaseBacklogModel.fromJson(res.toMap()['data']);
    } on AppwriteException catch (e) {
      debugPrint('appwrite \n $e');
      throw ServerException();
    } catch (e) {
      debugPrint(e.toString());
      throw ServerException();
    }
  }

  @override
  Future<List<ReleaseBacklogModel>> getReleaseBacklogsList(
      {required String projectId}) async {
    try {
      final res = await appWrite.getDataBase().listDocuments(
          databaseId: kScrumitDatabaseId,
          collectionId: kBacklogsCollectionId,
          //collectionId: kReleaseBacklogCollectionId,
          //TODO: implement get user project list
          queries: [
            Query.equal('projectId', projectId),
            Query.equal('type', 'release')
          ]);
      List<ReleaseBacklogModel> releaseBackloglist = [];

      for (var element in res.documents) {
        debugPrint(element.toMap()['data'].toString());
        releaseBackloglist
            .add(ReleaseBacklogModel.fromJson(element.toMap()['data']));
      }
      return releaseBackloglist;
    } on AppwriteException catch (e) {
      debugPrint('remote data source \n $e');
      throw ServerException();
    } catch (e) {
      debugPrint('remote data source \n $e');
      throw ServerException();
    }
  }

  @override
  Future<ReleaseBacklogModel> updateReleaseBacklog(
      {required ReleaseBacklog releaseBacklog, required String id}) async {
    try {
      final response = await appWrite.getDataBase().updateDocument(
          databaseId: kScrumitDatabaseId,
          collectionId: kBacklogsCollectionId,
          //collectionId: kReleaseBacklogCollectionId,
          documentId: id,
          data: ReleaseBacklogModel.fromDomain(releaseBacklog).toJson());
      //(project as ProjectModel).toJson());

      return ReleaseBacklogModel.fromJson(response.toMap()['data']);
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