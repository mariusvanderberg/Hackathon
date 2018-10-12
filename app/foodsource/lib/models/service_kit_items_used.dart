import 'package:foodsource/models/base_entity.dart';
import 'package:foodsource/models/service_kit_template_items.dart';
import 'package:foodsource/models/service_kit_used.dart';

class ServiceKitItemsUsed extends BaseEntity {
  @override
  get tableName => 'service_kit_items_used';
  @override
  get apiResourceName => 'service-kit-items-useds';

  int quantity;

  String serviceKitUsedId;
  ServiceKitUsed serviceKitUsed;

  String serviceKitTemplateItemsId;
  ServiceKitTemplateItems serviceKitTemplateItems;

  @override
  Map<String, dynamic> toMap() {
    super.toMap();
    map['quantity'] = quantity;

    if (serviceKitUsed != null) {
      map['serviceKitUsed'] = serviceKitUsed.toMap();
    }

    if (serviceKitTemplateItems != null) {
      map['serviceKitTemplateItems'] = serviceKitTemplateItems.toMap();
    }

    return map;
  }

  @override
  fromMap(Map map) {
    super.fromMap(map);
    quantity = map['quantity'];

    if (map.containsKey('serviceKitUsed') && map['serviceKitUsed'] != null) {
      var serviceKitUsedMap = map['serviceKitUsed'];
      serviceKitUsed.fromMap(serviceKitUsedMap);
      serviceKitUsedId = serviceKitUsed.id;
    }

    if (map.containsKey('serviceKitUsedId')) {
      serviceKitUsedId = map['serviceKitUsedId'];
      serviceKitUsed.id = serviceKitUsedId;
    }

    if (map.containsKey('serviceKitTemplateItems') && map['serviceKitTemplateItems'] != null) {
      var serviceKitTemplateItemsMap = map['serviceKitTemplateItems'];
      serviceKitTemplateItems.fromMap(serviceKitTemplateItemsMap);
      serviceKitTemplateItemsId = serviceKitTemplateItems.id;
    }

    if (map.containsKey('serviceKitTemplateItemsId')) {
      serviceKitTemplateItemsId = map['serviceKitTemplateItemsId'];
      serviceKitTemplateItems.id = serviceKitTemplateItemsId;
    }

  }
}
