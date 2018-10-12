import 'package:foodsource/models/base_entity.dart';

class User extends BaseEntity {
  @override
  get tableName => 'Users';
  @override
  get apiResourceName => 'users';

  String login;
  String localPassword;
  String firstName;
  String lastName;
  String email;
  String imageUrl;
  String avatar = 'assets/avatars/hasselhoffbaywatch-640x434.png'; // default avatar
  String accessToken;

  @override
  Map<String, dynamic> toMap() {
    super.toMap();
    super.map['login'] = login;
    super.map['firstName'] = firstName;
    super.map['lastName'] = lastName;
    super.map['email'] = email;
    super.map['imageUrl'] = imageUrl;
    super.map['accessToken'] = accessToken;

    if (localPassword != null && localPassword != '')
      super.map['localPassword'] = localPassword;
    return map;
  }

  @override
  fromMap(Map map) {
    super.fromMap(map);
    login = map['login'];
    firstName = map['firstName'];
    lastName = map['lastName'];
    email = map['email'];

    if (map.containsKey('imageUrl')) {
      imageUrl = map['imageUrl'];
    }

    if (map.containsKey('accessToken')) {
      accessToken = map['accessToken'];
    }

    if (map.containsKey('localPassword')) {
      localPassword = map['localPassword'];
    }
  }
}
