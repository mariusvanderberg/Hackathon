import 'package:foodsource/models/base_entity.dart';
import 'package:foodsource/models/address.dart';
import 'package:foodsource/models/client.dart';
import 'package:foodsource/models/target_type.dart';

class Target extends BaseEntity {
  @override
  get tableName => 'Targets';

  @override
  get apiResourceName => 'targets';

  String name;
  String description = '';

  String clientId;
  Client client = new Client();

  String addressId;
  Address address = new Address();

  String targetTypeId;
  TargetType targetType = new TargetType();

  @override
  Map<String, dynamic> toMap() {
    super.toMap();
    super.map['name'] = name;
    super.map['description'] = description;

    map['clientId'] = clientId;
    if (client != null) {
      map['client'] = client.toMap();
    }

    map['addressId'] = addressId;
    if (address != null) {
      map['address'] = address.toMap();
    }

    map['targetTypeId'] = targetTypeId;
    if (targetType != null) {
      map['targetType'] = targetType.toMap();
    }

    return super.map;
  }

  @override
  fromMap(Map map) {
    if (map == null || map.isEmpty) {
      return;
    }

    super.fromMap(map);
    name = map['name'];

    if (map.containsKey('description') && map['description'] != null) {
      description = map['description'];
    }

    if (map.containsKey('client') && map['client'] != null) {
      var clientMap = map['client'];
      client.fromMap(clientMap);
      clientId = client.id;
    }

    if (map.containsKey('clientId')) {
      clientId = map['clientId'];
      client.id = clientId;
    }

    if (map.containsKey('address') && map['address'] != null) {
      var addressMap = map['address'];
      address.fromMap(addressMap);
      addressId = address.id;
    }

    if (map.containsKey('addressId')) {
      addressId = map['addressId'];
      address.id = addressId;
    }

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
