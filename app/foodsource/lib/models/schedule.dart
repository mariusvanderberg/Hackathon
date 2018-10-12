import 'package:foodsource/models/base_entity.dart';
import 'package:foodsource/models/employee.dart';
import 'package:foodsource/models/target.dart';

class Schedule extends BaseEntity {
  @override
  get tableName => 'Schedules';

  @override
  get apiResourceName => 'schedules';

  String ical;

  String targetId;
  Target target;

  String employeeId;
  Employee employee;

  @override
  Map<String, dynamic> toMap() {
    super.toMap();

    super.map['ical'] = ical;

    map['targetId'] = targetId;
    map['employeeId'] = employeeId;

    if (target != null) {
      map['target'] = target.toMap();
    }

    if (employee != null) {
      map['employee'] = employee.toMap();
    }

    return super.map;
  }

  @override
  fromMap(Map map) {
    if (map == null || map.isEmpty) {
      return;
    }

    super.fromMap(map);

    ical = map['ical'];

    if (map.containsKey('target') && map['target'] != null) {
      var targetMap = map['target'];
      if (target == null) {
        target = new Target();
      }
      target.fromMap(targetMap);
      targetId = target.id;
    }

    if (map.containsKey('targetId')) {
      targetId = map['targetId'];
      target.id = targetId;
    }

    if (map.containsKey('employee') && map['employee'] != null) {
      var employeeMap = map['employee'];
      if (employee == null) {
        employee = new Employee();
      }
      employee.fromMap(employeeMap);
      employeeId = employee.id;
    }

    if (map.containsKey('employeeId')) {
      employeeId = map['employeeId'];
      employee.id = employeeId;
    }
  }
}
