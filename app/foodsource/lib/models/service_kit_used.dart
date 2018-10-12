import 'package:foodsource/models/base_entity.dart';
import 'package:foodsource/models/service_kit_template.dart';

class ServiceKitUsed extends BaseEntity {
  @override
  get tableName => 'service_kit_used';
  @override
  get apiResourceName => 'service-kit-useds';

  String serviceKitTemplateId;
  ServiceKitTemplate serviceKitTemplate;

  @override
  Map<String, dynamic> toMap() {
    super.toMap();

    if (serviceKitTemplate != null) {
      map['serviceKitTemplate'] = serviceKitTemplate.toMap();
    }

    return map;
  }

  @override
  fromMap(Map map) {
    super.fromMap(map);

    if (map.containsKey('serviceKitTemplate') && map['serviceKitTemplate'] != null) {
      var serviceKitTemplateMap = map['serviceKitTemplate'];
      serviceKitTemplate.fromMap(serviceKitTemplateMap);
      serviceKitTemplateId = serviceKitTemplate.id;
    }

    if (map.containsKey('serviceKitTemplateId')) {
      serviceKitTemplateId = map['serviceKitTemplateId'];
      serviceKitTemplate.id = serviceKitTemplateId;
    }
  }
}
