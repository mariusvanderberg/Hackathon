import 'package:foodsource/models/base_entity.dart';

class ClientGroup extends BaseEntity {
  @override
  get tableName => 'ClientGroups';

  @override
  get apiResourceName => 'client-groups';

  String name;

  @override
  Map<String, dynamic> toMap() {
    super.toMap();
    super.map['name'] = name;
    return super.map;
  }

  @override
  fromMap(Map map) {
    if (map == null || map.isEmpty) { 
      return;
    }

    super.fromMap(map);
    name = map['name'];
  }
}
