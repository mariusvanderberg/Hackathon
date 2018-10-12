import 'package:foodsource/models/base_entity.dart';
import 'package:foodsource/models/client_group.dart';

class Client extends BaseEntity {
  @override
  get tableName => 'Clients';

  @override
  get apiResourceName => 'clients';

  String name;
  String clientGroupId;
  ClientGroup clientGroup;

  @override
  Map<String, dynamic> toMap() {
    super.toMap();
    super.map['name'] = name;
    super.map['clientGroupId'] = clientGroupId;

    if (clientGroup != null) {
      super.map['clientGroup'] = clientGroup.toMap();
      if (clientGroupId == null) {
        clientGroupId = clientGroup.id == null ? clientGroup.id : "1";
        super.map['clientGroupId'] = clientGroupId;
      }
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

    if (map.containsKey('clientGroupId')) clientGroupId = map['clientGroupId'];

    if (map.containsKey('clientGroup')) {
      Map clientGroupMap = map['clientGroup'];
      if (clientGroupMap != null && clientGroupMap.isNotEmpty) {
        clientGroup = new ClientGroup();
        clientGroup.fromMap(clientGroupMap);
        clientGroupId = clientGroupMap['id'].toString();
      }
    }
  }
}
