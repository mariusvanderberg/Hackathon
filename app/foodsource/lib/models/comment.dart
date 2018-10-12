import 'package:foodsource/models/base_entity.dart';
import 'package:foodsource/models/employee.dart';
import 'package:foodsource/models/job.dart';

class Comment extends BaseEntity {
  @override
  get tableName => 'Comments';
  @override
  get apiResourceName => 'comments';

  String title;
  String comment;
  String jobId;
  String employeeId;

  Job job;
  Employee employee;

  @override
  Map<String, dynamic> toMap() {
    super.toMap();
    super.map['title'] = title;
    super.map['comment'] = comment;
    super.map['jobId'] = jobId;
    super.map['employeeId'] = employeeId;

    if (job != null) {
      super.map['job'] = job.toMap();
    }

    if (employee != null) {
      super.map['employee'] = employee.toMap();
    }
    
    return map;
  }

  @override
  fromMap(Map map) {
    super.fromMap(map);
    title = map['title'];
    comment = map['comment'];

    if (map.containsKey('employee') && map['employee'] != null) {
      var employeeMap = map['employee'];
      employee = new Employee();
      employee.fromMap(employeeMap);
      employeeId = employee.id;
    }

    if (map.containsKey('job') && map['job'] != null) {
      var jobMap = map['job'];
      job = new Job();
      job.fromMap(jobMap);
      jobId = job.id;
    }

    if (map.containsKey('jobId')) {
      jobId = map['jobId'];
      if (job == null) {
        job = new Job();
        job.id = jobId;
      }
    }

    if (map.containsKey('employeeId')) {
      employeeId = map['employeeId'];
      if (employee == null) {
        employee = new Employee();
        employee.id = employeeId;
      }
    }
  }
}
