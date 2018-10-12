import 'package:uuid/uuid.dart';

/// This is the Entity Base class
abstract class BaseEntity {
  int localId = -1;
  String id = new Uuid().v1().toString();
  String createdBy;
  DateTime createdDate = new DateTime.now();
  String lastModifiedBy;
  DateTime lastModifiedDate = new DateTime.now();
  bool isDeleted = false;
  bool isChanged = false;

  String get tableName => '';
  String get apiResourceName => '';
  Map<String, dynamic> map = new Map();

  Map<String, dynamic> toMap() {
    map = new Map();
    map['id'] = id;
    map['isChanged'] = isChanged;
    map['createdDate'] = createdDate.toIso8601String().endsWith('Z') ? createdDate.toIso8601String() : createdDate.toIso8601String() + 'Z';
    map['createdBy'] = createdBy;
    map['lastModifiedDate'] = lastModifiedDate.toIso8601String().endsWith('Z') ? lastModifiedDate.toIso8601String() : lastModifiedDate.toIso8601String() + 'Z';
    map['lastModifiedBy'] = lastModifiedBy;
    //map['localId'] = localId;
    //TODO:map the rest of the fields
    return map;
  }

  fromMap(Map map) {
    id = map['id'].toString();

    if (map.containsKey('localId')) localId = map['localId'];

    createdBy = map['createdBy'];
    isChanged = map['isChanged'] == 1;

    if (map['createdDate'] != null)
      createdDate = DateTime.parse(map['createdDate']);

    if (map['lastModifiedBy'] != null) lastModifiedBy = map['lastModifiedBy'];

    if (map['lastModifiedDate'] != null)
      lastModifiedDate = DateTime.parse(map['lastModifiedDate']);
  }
}
