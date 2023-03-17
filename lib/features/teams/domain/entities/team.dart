//"$id": "5e5ea5c16897e",
//     "$createdAt": "2020-10-15T06:38:00.000+00:00",
//     "$updatedAt": "2020-10-15T06:38:00.000+00:00",
//     "name": "VIP",
//     "total": 7
class Team {
  //from.Json
  final String id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String name;
  final int total;

  Team(
      {required this.id,
      required this.name,
      this.createdAt,
      this.updatedAt,
      required this.total});

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

class MemberShip {
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

  MemberShip(
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

  @override
  String toString() {
    return '''
              membership id: $id,
              
              ''';
  }
}
