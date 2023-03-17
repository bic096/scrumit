import 'package:scrumit/features/meetings/domain/entities/meeting.dart';

class MeetingDto {
  final String roomName;
  final String authToken;

  MeetingDto({required this.roomName, required this.authToken});

  factory MeetingDto.fromJson(Map<String, dynamic> json) =>
      MeetingDto(roomName: json['RoomName'], authToken: json['AuthToken']);

  Meeting toDomain() => Meeting(roomName: roomName, authToken: authToken);
}
