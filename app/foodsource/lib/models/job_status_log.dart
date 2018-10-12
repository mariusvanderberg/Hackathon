import 'package:foodsource/enums/job_status_enum.dart';
import 'package:foodsource/models/base_entity.dart';
import 'package:foodsource/models/job.dart';

class JobStatusLog extends BaseEntity {
  @override
  get tableName => 'jobStatusLog';

  @override
  get apiResourceName => 'job-status-logs';

  JobStatusEnum _dummyStatusEnum = JobStatusEnum.NEW;

  JobStatusEnum oldStatus;
  JobStatusEnum newStatus;
  DateTime transitionDate = new DateTime.now();
  String jobId;
  Job job;
  double latitude;
  double longitude;

  @override
  Map<String, dynamic> toMap() {
    super.toMap();
    super.map['oldStatus'] = oldStatus.stringValue;
    super.map['newStatus'] = newStatus.stringValue;
    super.map['transitionDate'] = transitionDate.toIso8601String().endsWith('Z')
        ? transitionDate.toIso8601String()
        : transitionDate.toIso8601String() + 'Z';
    super.map['jobId'] = jobId;

    if (job == null) {
      job = new Job();
      job.id = jobId;
    }
    super.map['job'] = job.toMap();

    super.map['latitude'] = latitude;
    super.map['latitude'] = longitude;

    return map;
  }

  @override
  fromMap(Map map) {
    super.fromMap(map);
    oldStatus = _dummyStatusEnum.valueOf(map['oldStatus']);
    newStatus = _dummyStatusEnum.valueOf(map['newStatus']);
    transitionDate = DateTime.parse(map['transitionDate']);

    if (job == null) {
      job = new Job();
    }

    if (map.containsKey('job') && ['job'] != null) {
      var jobMap = map['job'];
      job.fromMap(jobMap);
      jobId = job.id;
    }

    if (map.containsKey('jobId')) {
      jobId = map['jobId'];
      job.id = jobId;
    }

    if (map.containsKey('latitude')) {
      latitude = map['latitude'];
    }

    if (map.containsKey('longitude')) {
      longitude = map['longitude'];
    }
  }
}
