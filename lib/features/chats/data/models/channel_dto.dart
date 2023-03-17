import 'package:scrumit/features/chats/domain/entities/channels.dart';

class ChannelDto {
  final String id;
  final String projectId;
  final String channelName;
  final String channelDescription;

  ChannelDto(
      {required this.id,
      required this.projectId,
      required this.channelName,
      required this.channelDescription});

  factory ChannelDto.fromJson(Map<String, dynamic> json) => ChannelDto(
      id: json['id'],
      projectId: json['projectId'],
      channelName: json['channelName'],
      channelDescription: json['channelDescription']);

  factory ChannelDto.fromDomain(Channel channel) => ChannelDto(
      id: channel.id,
      projectId: channel.projectId,
      channelName: channel.channelName,
      channelDescription: channel.channelDescription);

  Map<String, dynamic> toJson() => {
        "id": id,
        "projectId": projectId,
        "channelName": channelName,
        "channelDescription": channelDescription
      };

  Channel toDomain() => Channel(
      id: id,
      projectId: projectId,
      channelName: channelName,
      channelDescription: channelDescription);

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
