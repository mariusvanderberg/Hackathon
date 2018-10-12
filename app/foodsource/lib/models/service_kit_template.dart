import 'package:foodsource/models/target_type.dart';
import 'package:foodsource/models/base_entity.dart';

class ServiceKitTemplate extends BaseEntity {
  @override
  get tableName => 'ServiceKitTemplates';

  @override
  get apiResourceName => 'service-kit-templates';

  String name;

  String targetTypeId;
  TargetType targetType = new TargetType();

//  String serviceKitTemplateItemsId;
//  List<ServiceKitTemplateItems> lstServiceKitTemplateItems = new List<ServiceKitTemplateItems>();

  @override
  Map<String, dynamic> toMap() {
    super.toMap();
    map['name'] = name;

    if (targetType != null) {
      map['targetType'] = targetType.toMap();
    }

    if (targetTypeId != null) {
      super.map['targetTypeId'] = targetTypeId;
    }

    return map;
  }

  @override
  fromMap(Map map) {
    super.fromMap(map);
    name = map['name'];

    if (map.containsKey('targetType') && map['targetType'] != null) {
      var targetTypeMap = map['targetType'];
      targetType.fromMap(targetTypeMap);
      targetTypeId = targetType.id;
    }

    if (map.containsKey('targetTypeId')) {
      targetTypeId = map['targetTypeId'];
      targetType.id = targetTypeId;
    }
  }
}
