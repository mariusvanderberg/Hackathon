import 'package:foodsource/models/base_entity.dart';

class Company extends BaseEntity {
  @override
  get tableName => 'Companies';

  @override
  get apiResourceName => 'companies';

  String name;
  String description;

  @override
  Map<String, dynamic> toMap() {
    super.toMap();
    super.map['name'] = name;
    super.map['description'] = description;
    return super.map;
  }

  @override
  fromMap(Map map) {
    if (map == null || map.isEmpty) { 
      return;
    }

    super.fromMap(map);
    name = map['name'];
    description = map['description'];
  }
}
