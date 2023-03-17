class Meeting {
  final String roomName;
  final String authToken;

  Meeting({required this.roomName, required this.authToken});

  @override
  String toString() {
    return ''' $roomName
               $authToken
               ''';
  }
}
