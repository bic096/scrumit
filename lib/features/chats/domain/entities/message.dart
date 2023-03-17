class Message {
  final String id;
  final String channelId;
  final String ownerId;
  final String message;
  final String messageType;

  Message(
      {required this.id,
      required this.channelId,
      required this.ownerId,
      required this.message,
      required this.messageType});

  @override
  String toString() {
    return '''
                final String $id;
                final String $channelId;
                final String $ownerId;
                final String $message;
                final String $messageType;
  ''';
  }
}
