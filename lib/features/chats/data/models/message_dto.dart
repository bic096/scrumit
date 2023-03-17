import 'package:scrumit/features/chats/domain/entities/message.dart';

class MessageDto {
  final String id;
  final String channelId;
  final String ownerId;
  final String message;
  final String messageType;

  MessageDto(
      {required this.id,
      required this.channelId,
      required this.ownerId,
      required this.message,
      required this.messageType});

  factory MessageDto.fromJson(Map<String, dynamic> json) => MessageDto(
      id: json['\$id'],
      channelId: json['channelId'],
      ownerId: json['ownerId'],
      message: json['message'],
      messageType: json['messageType']);

  factory MessageDto.fromDomain(Message message) => MessageDto(
      id: message.id,
      channelId: message.channelId,
      ownerId: message.ownerId,
      message: message.message,
      messageType: message.messageType);

  Map<String, dynamic> toJson() => {
        "channelId": channelId,
        "ownerId": ownerId,
        "message": message,
        "messageType": messageType
      };

  Message toDomain() => Message(
      id: id,
      channelId: channelId,
      ownerId: ownerId,
      message: message,
      messageType: messageType);

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
