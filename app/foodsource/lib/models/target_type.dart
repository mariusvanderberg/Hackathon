import 'package:foodsource/models/base_entity.dart';

class TargetType extends BaseEntity {
  @override
  get tableName => 'TargetTypes';

  @override
  get apiResourceName => 'target-types';

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
