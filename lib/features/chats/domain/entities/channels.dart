class Channel {
  final String id;
  final String projectId;
  final String channelName;
  final String channelDescription;

  Channel(
      {required this.id,
      required this.projectId,
      required this.channelName,
      required this.channelDescription});

  Channel copyWith({String? channelName, String? channelDescription}) =>
      Channel(
          id: id,
          projectId: projectId,
          channelName: channelName ?? this.channelName,
          channelDescription: channelDescription ?? this.channelDescription);

  @override
  String toString() {
    return '''
          final String $id;
          final String $projectId;
          final String $channelName;
          final String $channelDescription;
                      ''';
  }
}
