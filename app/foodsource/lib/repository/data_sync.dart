import 'dart:async';
import 'package:foodsource/models/address.dart';
import 'package:foodsource/models/base_entity.dart';
import 'package:foodsource/models/checklist.dart';
import 'package:foodsource/models/section.dart';
import 'package:foodsource/models/client.dart';
import 'package:foodsource/models/employee.dart';
import 'package:foodsource/models/images.dart';
import 'package:foodsource/models/job.dart';
import 'package:foodsource/models/target.dart';
import 'package:foodsource/models/user.dart';
import 'package:foodsource/repository/i_repository.dart';
import 'package:foodsource/repository/local_repository.dart';
import 'package:foodsource/repository/repository.dart';
import 'package:foodsource/repository/rest_repository.dart';
import 'package:foodsource/models/job_status_log.dart';
import 'package:foodsource/models/user_comment.dart';
import 'package:foodsource/models/schedule.dart';

class DataSync {
  List<BaseEntity> orderedEntitySyncUpList = [
//    Schedule(),
    Job(),
//    Checklist(),
//    ChecklistItem(),
    Images(),
//    JobStatusLog(),
//    UserComment()
  ];
  List<BaseEntity> orderedEntitySyncDownList = [
//    Job(),
//    Address(),
//    Employee(),
//    User(),
//    Schedule(),
    Client(),
//     Target()
//     User(),
//     UserComment()
  ];

  final IRepository repository = new Repository();
  final LocalRepository _localRepository = new LocalRepository();
  final RestRepository _restRepository = new RestRepository();
  static final DataSync _dataSync = new DataSync._internal();

  factory DataSync() {
    return _dataSync;
  }

  DataSync._internal();

  Future<void> runSync() async {
    for (var entity in orderedEntitySyncUpList) {
      await _syncUp(entity);
    }
    for (var entity in orderedEntitySyncDownList) {
      await _syncDown(entity);
    }
  }

  Future<void> syncUp(BaseEntity entity) async {
    if (orderedEntitySyncUpList
        .any((item) => item.runtimeType == entity.runtimeType)) {
      await _syncUp(entity);
    }
  }

  Future<void> _syncUp(BaseEntity entity) async {
    try {
      List<Map> returnedMappedEntities =
          await _localRepository.getLocalItemsToSync(entity.tableName);
      if (returnedMappedEntities == null) return;
      for (var item in returnedMappedEntities) {
        entity.fromMap(item);
        await repository.save(entity, true);
      }
    } on Exception catch (ex) {
      print('Cannot sync up due to: ' + ex.toString());
    }
  }

  _syncDown(BaseEntity entity) async {
    try {
      List<Map> returnedMappedEntities =
          await _restRepository.getList(entity.apiResourceName);
      if (returnedMappedEntities == null) {
        return;
      }
      for (var item in returnedMappedEntities) {
        entity.fromMap(item);
        await _localRepository.save(entity, false);
      }
    } on Exception catch (ex) {
      print('Cannot sync down due to: ' + ex.toString());
    }
  }
}
