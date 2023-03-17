import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:scrumit/core/errors/failures.dart';
import 'package:scrumit/features/projects/domain/entities/project.dart';
import 'package:scrumit/features/projects/domain/usecases/project_usecases.dart';

enum RequestStatus { success, faild, looding, idel }

class ProjectController extends GetxController {
  final GetProject getProject;
  final GetProjectList getProjectList;
  final CreateProject createProject;
  ProjectController(
      {required this.createProject,
      required this.getProject,
      required this.getProjectList});

  RxList<Project> projectList = <Project>[].obs;
  RxString projectName = ''.obs;
  RxString projectDescription = ''.obs;

  RxString _currentProjectId = ''.obs;

  Rx<RequestStatus> requestStatus = RequestStatus.idel.obs;

  final Rx<Project> _currentProject = Project(
          projectName: 'projectName',
          ownerId: 'ownerId',
          startDate: DateTime.now(),
          endDate: DateTime.now(),
          description: 'description',
          teamId: '')
      .obs;
  // @override
  // void onInit() {
  //   debugPrint('from onInit()');
  //   listProjects('1');
  //   super.onInit();
  // }

  void projectCopyWith(
      {String? name,
      String? description,
      DateTime? startDate,
      DateTime? endDate,
      String? ownerId}) {
    _currentProject(_currentProject.value.copyWith(
        name: name,
        description: description,
        startDate: startDate,
        endDate: endDate,
        ownerId: ownerId));
  }

  set currentProject(Project project) {
    _currentProject(project);
  }

  Project get currentProject {
    return _currentProject.value;
  }

  // void listProjects(String ownerId) async {
  void listProjects(List<String> teamIds) async {
    requestStatus(RequestStatus.looding);
    final failureOrList =
        await getProjectList(params: Params(teamIds: teamIds));
    failureOrList.fold((Failure l) {
      requestStatus(RequestStatus.faild);
      debugPrint(l.toString());
    }, (List<Project> r) {
      requestStatus(RequestStatus.success);
      // debugPrint(r[1].toString());
      // debugPrint(r[1].createdAt!.toIso8601String());
      projectList(r);
    });
  }

  void projectDetails(String projectId) async {
    final failureOrProject =
        await getProject(params: Params(projectId: projectId));

    failureOrProject.fold((l) {
      requestStatus(RequestStatus.faild);
    }, (Project r) {
      requestStatus(RequestStatus.success);
      debugPrint(r.toString());
      // debugPrint(r[1].createdAt!.toIso8601String());
      // projectList(r);
      currentProject = r;
    });
  }

  Future<void> addProject(Project project) async {
    final failureOrproject =
        await createProject(params: Params(project: project));
    failureOrproject.fold((l) {
      requestStatus(RequestStatus.faild);
    }, (r) {
      requestStatus(RequestStatus.success);
    });
  }

  void listProductBacklog() async {
    //TODO: impel ListProductBacklog method
  }
  void createProductBacklog() async {}

  void listFeatureBacklog() async {}
  void createFeatureBacklog() async {}

  set currentProjectId(String projectId) {
    _currentProjectId(projectId);
  }

  String get currentProjectId {
    return _currentProjectId.value;
  }
}
