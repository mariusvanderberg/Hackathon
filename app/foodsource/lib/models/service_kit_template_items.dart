import 'package:foodsource/models/base_entity.dart';

class ServiceKitTemplateItems extends BaseEntity {
  @override
  get tableName => 'ServiceKitTemplateItems';
  @override
  get apiResourceName => 'service-kit-template-items';

  //ServiceKitTemplate serviceKitTemplate = new ServiceKitTemplate();
  String name;
  int quantity;
  String serviceKitTemplateId;

  @override
  Map<String, dynamic> toMap() {
    super.toMap();
    map['name'] = name;
    map['quantity'] = quantity;
    super.map['serviceKitTemplateId'] = serviceKitTemplateId;

//    if (serviceKitTemplate != null) {
//      super.map['serviceKitTemplate'] = serviceKitTemplate.toMap();
//    }

    return map;
  }

  @override
  fromMap(Map map) {
    super.fromMap(map);
    name = map['name'];
    quantity = map['quantity'];

//    if (map.containsKey('serviceKitTemplate') && map['serviceKitTemplate'] != null) {
//      var serviceKitTemplateMap = map['serviceKitTemplate'];
//      serviceKitTemplate = new ServiceKitTemplate();
//      serviceKitTemplate.fromMap(serviceKitTemplateMap);
//      serviceKitTemplateId = serviceKitTemplate.id;
//    }

    if (map.containsKey('serviceKitTemplateId')) {
      serviceKitTemplateId = map['serviceKitTemplateId'];
      //serviceKitTemplate.id = serviceKitTemplateId;
    }
  }
}
