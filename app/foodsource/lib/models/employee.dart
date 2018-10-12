import 'package:foodsource/models/base_entity.dart';
import 'package:foodsource/models/user.dart';
import 'package:foodsource/models/company.dart';

class Employee extends BaseEntity {
  @override
  get tableName => 'Employees';
  @override
  get apiResourceName => 'employees';

  String displayName;
  String mobileNumber;
  User user;
  String userId;
  Company company;
  String companyId;

  @override
  Map<String, dynamic> toMap() {
    super.toMap();
    super.map['displayName'] = displayName;
    super.map['mobileNumber'] = mobileNumber;
    super.map['userId'] = userId;
    super.map['companyId'] = companyId;

    if (user != null) {
      super.map['user'] = user.toMap();
      if (userId == null) {
        userId = user.id;
        super.map['userId'] = userId;
      }
    }

    if (company != null) {
      super.map['company'] = company.toMap();
      if (companyId == null) {
        companyId = company.id == null ? company.id : "1";
        super.map['companyId'] = companyId;
      }
    }

    // map['user'] = new Map();
    // map['user']['id'] = user.id;

    return super.map;
  }

  @override
  fromMap(Map map) {
    if (map == null || map.isEmpty) {
      return;
    }

    if (map.containsKey('localId')) localId = map['localId'];

    if (map.containsKey('userId')) userId = map['userId'];

    if (map.containsKey('companyId')) companyId = map['companyId'];

    id = map['id'].toString();
    displayName = map['displayName'];
    mobileNumber = map['mobileNumber'];

    if (map.containsKey('user')) {
      var userMap = map['user'];
      if (userMap != null) {
        user = new User();
        user.fromMap(userMap);
        userId = user.id;
      }
    }

    if (map.containsKey('company')) {
      Map companyMap = map['company'];
      if (companyMap != null && companyMap.isNotEmpty) {
        company = new Company();
        company.fromMap(companyMap);
        companyId = companyMap['id'].toString();
      }
    }
  }
}
