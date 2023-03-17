//"$id": "5e5ea5c16897e",
//     "$createdAt": "2020-10-15T06:38:00.000+00:00",
//     "$updatedAt": "2020-10-15T06:38:00.000+00:00",
//     "name": "VIP",
//     "total": 7
import 'package:scrumit/features/teams/domain/entities/team.dart';

class TeamModel {
  //from.Json
  final String id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String name;
  final int total;

  TeamModel(
      {required this.id,
      required this.name,
      this.createdAt,
      this.updatedAt,
      required this.total});

  factory TeamModel.fromJson(Map<String, dynamic> json) =>
      TeamModel(id: json['\$id'], name: json['name'], total: json['total']);

  factory TeamModel.fromDomain(Team team) =>
      TeamModel(id: team.id, name: team.name, total: team.total);

  Team toDomain() => Team(id: id, name: name, total: total);
  @override
  String toString() {
    return '''
              team name: $name,
              total members: $total
              ''';
  }

  //fromDomain

  // toJson

  //toDomain
//copyWith
  //toString
}

// {
//     "total": 5,
//     "memberships": {
//         "$id": "5e5ea5c16897e",
//         "$createdAt": "2020-10-15T06:38:00.000+00:00",
//         "$updatedAt": "2020-10-15T06:38:00.000+00:00",
//         "userId": "5e5ea5c16897e",
//         "userName": "John Doe",
//         "userEmail": "john@appwrite.io",
//         "teamId": "5e5ea5c16897e",
//         "teamName": "VIP",
//         "invited": "2020-10-15T06:38:00.000+00:00",
//         "joined": "2020-10-15T06:38:00.000+00:00",
//         "confirm": false,
//         "roles": [
//             "admin"
//         ]
//     }
// }

// {$id: 63bfd4acb8ee06dcf746,
//  $createdAt: 2023-01-12T09:36:44.757+00:00,
//   $updatedAt: 2023-01-12T09:36:44.757+00:00,
//   userId: 63bafdb2aa54be197a0f,
//   userName: ,
//   userEmail: b@b.b,
//   teamId: 63bfd4acb2ba4afa25c9,
//   teamName: teamteam,
//   invited: 2023-01-12T09:36:44.757+00:00, j
//   oined: 2023-01-12T09:36:44.757+00:00,
//   confirm: true, roles: [owner]}

class MemberShipModel {
  final String id;
  final String userId;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  final String? userName;
  final String userEmail;
  final String? teamId;
  final String? teamName;
  final DateTime? invited;
  final DateTime? joined;
  final bool? confirm;
  final List<dynamic>? roles;

  MemberShipModel(
      {required this.id,
      required this.userId,
      this.createdAt,
      this.updatedAt,
      this.userName,
      required this.userEmail,
      this.teamId,
      this.teamName,
      this.invited,
      this.joined,
      this.confirm,
      this.roles});

  factory MemberShipModel.fromJson(Map<String, dynamic> json) =>
      MemberShipModel(
          id: json['\$id'],
          userId: json['userId'],
          userEmail: json['userEmail'],
          roles: json['roles']);

  factory MemberShipModel.fromDomain(MemberShip memberShip) => MemberShipModel(
      id: memberShip.id,
      userId: memberShip.userId,
      userEmail: memberShip.userEmail);

  MemberShip toDomain() =>
      MemberShip(id: id, userEmail: userEmail, userId: userId, roles: roles);

  @override
  String toString() {
    return '''
              membership id: $id,
              
              ''';
  }
}
