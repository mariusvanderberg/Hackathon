import 'package:foodsource/enums/job_actions_enum.dart';
import 'package:foodsource/enums/job_status_enum.dart';
import 'package:foodsource/models/address.dart';
import 'package:foodsource/models/base_entity.dart';
import 'package:foodsource/models/employee.dart';
import 'package:foodsource/models/target.dart';
import 'package:foodsource/models/schedule.dart';

class Job extends BaseEntity {
  @override
  get tableName => 'Jobs';

  @override
  get apiResourceName => 'jobs';

  String jobNumber;
  String description;

  String statusId;
  JobStatusEnum status = JobStatusEnum.NEW;

  DateTime scheduledDate;
  DateTime startDate;
  DateTime completedDate;
  String notes;
  String title;
  bool rescheduled;

  String employeeId;
  Employee employee;

  String addressId;
  Address address = new Address();

  JobActionsEnum action;

  String scheduleId;
  Schedule schedule = new Schedule();

  String targetId;
  Target target = new Target();

  bool isMissed = false;
  bool isUpcoming = false;

  @override
  Map<String, dynamic> toMap() {
    super.toMap();
    map['jobNumber'] = jobNumber;
    map['description'] = description;
    map['status'] = status.stringValue;
    map['statusId'] = status.val;
    if (scheduledDate != null)
      map['scheduledDate'] = scheduledDate.toIso8601String().endsWith('Z')
          ? scheduledDate.toIso8601String()
          : scheduledDate.toIso8601String().endsWith('Z');
    if (startDate != null)
      map['startDate'] = startDate.toIso8601String().endsWith('Z')
          ? startDate.toIso8601String()
          : startDate.toIso8601String().endsWith('Z');
    if (completedDate != null)
      map['completedDate'] = completedDate.toIso8601String().endsWith('Z')
          ? completedDate.toIso8601String()
          : completedDate.toIso8601String().endsWith('Z');
    map['notes'] = notes;
    map['title'] = title;
    map['rescheduled'] = rescheduled;
    map['employeeId'] = employeeId;
    map['addressId'] = addressId;
    map['targetId'] = targetId;
    map['scheduleId'] = scheduleId;

    if (employee != null) {
      map['employee'] = employee.toMap();
    }

    if (schedule != null) {
      map['schedule'] = schedule.toMap();
    }

    if (target != null) {
      map['target'] = target.toMap();
    }

    if (address != null) {
      map['address'] = address.toMap();
    }

    return map;
  }

  @override
  fromMap(Map map) {
    super.fromMap(map);
    jobNumber = map['jobNumber'];
    description = map['description'];
    status = status.valueOf(map['status']);
    statusId = status.val.toString();

    if (map['scheduledDate'] != null) {
      scheduledDate = DateTime.parse(map['scheduledDate']);
    }

    if (map['startDate'] != null) {
      startDate = DateTime.parse(map['startDate']);
    }

    if (map['completedDate'] != null) {
      completedDate = DateTime.parse(map['completedDate']);
    }

    if (map['notes'] != null) {
      notes = map['notes'];
    }

    if (map['title'] != null) {
      title = map['title'];
    }

    setValue('rescheduled', rescheduled);

    if (map.containsKey('employee') && map['employee'] != null) {
      var employeeMap = map['employee'];
      if (employee == null) {
        employee = new Employee();
      }
      employee.fromMap(employeeMap);
      employeeId = employee.id;
    }

    if (map.containsKey('target')) {
      var targetMap = map['target'];
      if (target == null) {
        target = new Target();
      }
      target.fromMap(targetMap);
      targetId = target.id;

      if (targetMap.containsKey('address')) {
        var addressMap = targetMap['address'];
        if (address == null) {
          address = new Address();
        }
        address.fromMap(addressMap);
        addressId = address.id;
      }
    }

    if (map.containsKey('schedule') && map['schedule'] != null) {
      var scheduleMap = map['schedule'];
      schedule.fromMap(scheduleMap);
      if (scheduleMap.containsKey('id')) {
        scheduleId = scheduleMap['id'].toString();
      }
    }

    if (map.containsKey('employeeId')) {
      employeeId = map['employeeId'];
      if (employee == null) {
        employee = new Employee();
      }
      employee.id = employeeId;
    }

    if (map.containsKey('scheduleId')) {
      scheduleId = map['scheduleId'];
      if (schedule == null) {
        schedule = new Schedule();
      }
      schedule.id = scheduleId;
    }

    if (map.containsKey('addressId')) {
      addressId = map['addressId'];
      if (address == null) {
        address = new Address();
      }
      address.id = addressId;
    }

    if (map.containsKey('targetId')) {
      targetId = map['targetId'];
      if (target == null) {
        target = new Target();
      }
      target.id = targetId;
    }

    this.setJobAction();
  }

  void setValue(String keyName, Object param) {
    if (map[keyName] != null) {
      param = map[keyName];
    }
  }

  void setJobAction() {
    this.action = JobActionsEnum.SCHEDULE;
    if (this.status == JobStatusEnum.SCHEDULED) {
      this.action = JobActionsEnum.START;
    } else if (this.status == JobStatusEnum.INPROGRESS) {
      this.action = JobActionsEnum.COMPLETE;
    }
  }
}
