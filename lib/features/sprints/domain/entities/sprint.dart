class Sprint {
  final String id;
  final String projecId;
  final int sprintNum;
  final DateTime startingDate;
  final DateTime endDate;
  final String status;
  final String? sprintPlanning;
  final String? sprintReview;
  final String? retrospective;
  final List<dynamic> dailyScrum;
  final List<String?> tasks;

  Sprint(
      {required this.id,
      required this.projecId,
      required this.sprintNum,
      required this.startingDate,
      required this.endDate,
      required this.status,
      this.sprintPlanning,
      this.sprintReview,
      this.retrospective,
      required this.dailyScrum,
      required this.tasks});

  Sprint copyWith(
      {String? projectId,
      int? sprintNum,
      DateTime? startingDate,
      DateTime? endDate,
      String? status,
      String? sprintPlaning,
      String? sprintReview,
      String? retrospective}) {
    return Sprint(
        id: id,
        projecId: projectId ?? projecId,
        sprintNum: sprintNum ?? this.sprintNum,
        startingDate: startingDate ?? this.startingDate,
        endDate: endDate ?? this.endDate,
        status: status ?? this.status,
        dailyScrum: dailyScrum,
        tasks: tasks,
        sprintPlanning: sprintPlaning ?? sprintPlanning,
        sprintReview: sprintReview ?? this.sprintReview,
        retrospective: retrospective ?? this.retrospective);
  }

  @override
  String toString() {
    return '''
              final String $id;
              final String $projecId;
              final int $sprintNum;
              final DateTime $startingDate;
              final DateTime $endDate;
              final String $status;
              final String? $sprintPlanning;
              final String? $sprintReview;
              final String? $retrospective;
              final List<dynamic>? $dailyScrum;
              final List<String?> $tasks;
                ''';
  }
}
