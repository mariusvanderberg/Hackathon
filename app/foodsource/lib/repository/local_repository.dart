import 'dart:async';
import 'package:foodsource/exceptions/unauthorised_exception.dart';
import 'package:foodsource/models/address.dart';
import 'package:foodsource/models/base_entity.dart';
import 'package:foodsource/models/checklist.dart';
import 'package:foodsource/models/section.dart';
import 'package:foodsource/models/client.dart';
import 'package:foodsource/models/employee.dart';
import 'package:foodsource/models/job.dart';
import 'package:foodsource/models/schedule.dart';
import 'package:foodsource/models/service_kit_template.dart';
import 'package:foodsource/models/service_kit_template_items.dart';
import 'package:foodsource/models/target.dart';
import 'package:foodsource/models/user.dart';
import 'package:foodsource/models/user_comment.dart';
import 'package:foodsource/repository/database.dart';
import 'package:foodsource/repository/filter.dart';
import 'package:foodsource/repository/i_repository.dart';
import 'package:foodsource/models/images.dart';

class LocalRepository extends IRepository<BaseEntity> {
  DBHelper dbHelper = new DBHelper();

  LocalRepository() {
    dbHelper.getDatabase();
  }

  Future<List<Map>> getLocalItemsToSync(String entityName) async {
    var whereClause = 'isChanged = ?';
    var returnedItems =
        await _getList(entityName, whereClause: whereClause, parameters: [1]);
    return returnedItems;
  }

  Future<Map> _get(String entityName, {String id, String whereClause}) async {
    if (whereClause == null) {
      var map = await dbHelper.getEntity(entityName, id);
      return map;
    }

    var mapList =
        await dbHelper.getEntityWithWhere(entityName, whereClause, [id]);
    if (mapList != null && mapList.length > 0) return mapList.first;

    return null;
  }

  Future<List<Map>> _getList(String entityName,
      {String whereClause, List<dynamic> parameters}) async {
    var returnValue = await dbHelper.getEntitiesWithWhere(entityName,
        whereClause: whereClause, parameters: parameters);
    return returnValue;
  }

  Future<bool> _doesExist(String entityTableName, String id) async {
    var doesExist = await dbHelper.doesExist(entityTableName, id);
    return doesExist;
  }

  Future<BaseEntity> _insert(BaseEntity entity, isChanged) async {
    return await dbHelper.insert(entity, isChanged);
  }

  Future<int> _update(BaseEntity entity, isChanged) async {
    return await dbHelper.update(entity, isChanged);
  }

  @override
  Future<BaseEntity> save(BaseEntity entity, bool isChanged) async {
    var exists = await _doesExist(entity.tableName, entity.id);
    if (exists == null || exists == false) {
      await _insert(entity, isChanged);
    } else {
      await _update(entity, isChanged);
    }

    return entity;
  }

  @override
  Future<List<BaseEntity>> saveList(
      List<BaseEntity> entities, bool isChanged) async {
    var newEntityList = new List<BaseEntity>();
    for (var entity in entities) {
      var saveResult = await save(entity, isChanged);
      newEntityList.add(saveResult);
    }
    return newEntityList;
  }

  Future<BaseEntity> getEntity(BaseEntity emptyEntity, String id) async {
    var entityMap = await dbHelper.getEntity(emptyEntity.tableName, id);
    emptyEntity.fromMap(entityMap);
    return emptyEntity;
  }

  //TODO: Write a List method:

  //TODO: Get a way to pass through Where statements:

  Future<int> delete(BaseEntity entity) async {
    return await dbHelper.delete(entity);
  }

  @override
  Future<String> login(String username, String password) async {
    var user = new User();
    var mapValue =
        await _get(user.tableName, whereClause: 'login = ?', id: username);
    if (mapValue == null) {
      mapValue =
          await _get(user.tableName, whereClause: 'email = ?', id: username);
    }
    user.fromMap(mapValue);

    if (user == null)
      throw new UnauthorisedException(
          "Please check your connection before logging in for the first time",
          null);

    if (user.localPassword != password)
      throw new UnauthorisedException(
          "Your username or password is incorrect", null);

    var returnValue = user.accessToken;
    return returnValue;
  }

  @override
  Future<Job> getJob(String id) async {
    var job = new Job();
    job = await this.getEntity(job, id);
    return job;
  }

  @override
  Future<List<Job>> getJobs([String employeeId]) async {
    var job = new Job();
    var jobs = new List<Job>();
    var returnedMaps;
    if (employeeId != null) {
//      returnedMaps = await _getList(job.tableName, whereClause: 'employeeId = ? AND statusId > ?', parameters: [employeeId, '4']);
      returnedMaps = await _getList(job.tableName, whereClause: 'employeeId = ?', parameters: [employeeId]);
    } else {
      returnedMaps = await _getList(job.tableName);
    }

    for (int cnt = 0; cnt < returnedMaps.length; cnt++) {
      job = new Job();
      job.fromMap(returnedMaps[cnt]);
      if (job.addressId != null) {
        var address = await getAddress(job.addressId);
        job.address = address;
      }
////TODO: Add comments here
//      if (job.commentid != null) {
//        var comment = await this.getComment(job.commentid);
//        job.comment = comment;
//      }

      if (job.employeeId != null) {
        var employee = await this.getEmployee(job.employeeId);
        job.employee = employee;
      }

      if (job.scheduleId != null) {
        var schedule = await this.getSchedule(job.scheduleId);
        job.schedule = schedule;
      }

      if (job.targetId != null) {
        var target = await this.getTarget(job.targetId);
        job.target = target;
      }

      jobs.add(job);
    }

//    for (var itemMap in returnedMaps) {
//      job = new Job();
//      job.fromMap(itemMap);
//      if (job.jobSubTypeId != null && jobSubTypes != null) {
//        job.jobSubType = jobSubTypes
//            .firstWhere((jobSubType) => jobSubType.id == job.jobSubTypeId);
//      }
//      if (job.address.id != null) {
//        var address = await this.getAddress(job.address.id);
//        job.address = address;
//      }
//      if (job.employeeId != null) {
//        var employee = await this.getEmployeeByUsername(username);
//        job.employee = employee;
//      }
//      jobs.add(job);
//    }
    return jobs;
  }

  Future<List<Job>> getOpenJobs({whereClause, List<dynamic> parameters}) async {
    var job = new Job();
    var jobs = new List<Job>();
    var returnedMaps = await _getList(job.tableName,
        whereClause: whereClause, parameters: parameters);

    for (int cnt = 0; cnt < returnedMaps.length; cnt++) {
      job = new Job();
      job.fromMap(returnedMaps[cnt]);
      if (job.addressId != null) {
        var address = await getAddress(job.addressId);
        job.address = address;
      }

      if (job.employeeId != null) {
        var employee = await this.getEmployee(job.employeeId);
        job.employee = employee;
      }

      if (job.scheduleId != null) {
        var schedule = await this.getSchedule(job.scheduleId);
        job.schedule = schedule;
      }

      if (job.targetId != null) {
        var target = await this.getTarget(job.targetId);
        job.target = target;
      }

      jobs.add(job);
    }

    return jobs;
  }

  @override
  Future<Images> getImage(String id) async {
    return await this.getEntity(new Images(), id);
  }

  @override
  Future<List<Images>> getImagesByJobId(String jobId) async {
    var image = new Images();
    var images = new List<Images>();
    var returnedMaps = await _getList(image.tableName,
        whereClause: 'jobId = ?', parameters: [jobId]);

    for (var itemMap in returnedMaps) {
      image = new Images();
      image.fromMap(itemMap);
      images.add(image);
    }

    return images;
  }

  @override
  Future<Employee> getEmployeeByUsername(String username,
      {String password}) async {
    var employee = new Employee();
    employee.user = new User();
    var userMap = await this
        ._get(employee.user.tableName, whereClause: 'login = ?', id: username);

    employee.user.fromMap(userMap);

    var value = await this._get(employee.tableName,
        whereClause: 'userId = ?', id: employee.user.id);
    employee.fromMap(value);

    return employee;
  }

  @override
  Future<List<Checklist>> getChecklists() async {
    var checklist = new Checklist();
    var checklistMaps = await this._getList(checklist.tableName);
    List<Checklist> checklists = new List();
    for (var checklistMap in checklistMaps) {
      checklist = new Checklist();
      checklist.fromMap(checklistMap);
      checklists.add(checklist);
    }
    return checklists;
  }

  @override
  Future<Checklist> getChecklist(String id) async {
    var checklist = new Checklist();
    var checklistMap = await this._get(checklist.tableName, id: id);
    if (checklistMap == null) {
      return null;
    }
    checklist.fromMap(checklistMap);
    return checklist;
  }

  @override
  Future<List<Section>> getSectionsByCheckListId(
      String checklistId) async {
    var section = new Section();
    var values = await this._getList(section.tableName,
        whereClause: 'checklistId = ?', parameters: [checklistId]);
    List<Section> lstSection = new List();
    for (int cnt = 0; cnt < values.length; cnt++) {
      section = new Section();
      section.fromMap(values[cnt]);
      lstSection.add(section);
    }
    return lstSection;
  }

  @override
  Future<List<Checklist>> getChecklistsByTargetId(String targetId) async {
    var checklist = new Checklist();
    var checklistMaps = await this._getList(checklist.tableName,
        whereClause: 'targetId = ?', parameters: [targetId]);
    List<Checklist> checklists = new List();
    for (var checklistMap in checklistMaps) {
      checklist = new Checklist();
      checklist.fromMap(checklistMap);
      checklists.add(checklist);
    }
    return checklists;
  }

  @override
  Future<List<UserComment>> getUserComments() async {
    var userComment = new UserComment();
    var userCommentMaps = await _getList(userComment.tableName);
    List<UserComment> userComments = new List();
    for (var userCommentMap in userCommentMaps) {
      userComment = new UserComment();
      userComment.fromMap(userCommentMap);
      userComments.add(userComment);
    }
    return userComments;
  }

  @override
  Future<UserComment> getUserComment(String id) async {
    var userComment = new UserComment();
    var userCommentMap = await this._get(userComment.tableName, id: id);
    if (userCommentMap == null) {
      return null;
    }

    userComment.fromMap(userCommentMap);
    return userComment;
  }

  @override
  Future<List<UserComment>> getUserCommentByJobId(String jobId) async {
    var userComment = new UserComment();
    var userCommentMaps = await _getList(userComment.tableName,
        whereClause: 'jobId = ?', parameters: [jobId]);
    List<UserComment> userComments = new List();
    for (var userCommentMap in userCommentMaps) {
      userComment = new UserComment();
      userComment.fromMap(userCommentMap);

      if (userComment.employeeId != null) {
        var employee = await this.getEmployee(userComment.employeeId);
        userComment.employee = employee;
      }

      userComments.add(userComment);
    }
    return userComments;
  }

  @override
  Future<Address> getAddress(String id) async {
    var address = new Address();
    address = await this.getEntity(address, id);
    return address;
  }

  @override
  Future<Employee> getEmployee(String id) async {
    var employee = new Employee();
    employee = await this.getEntity(employee, id);
    return employee;
  }

  @override
  Future<Schedule> getSchedule(String id) async {
    var schedule = new Schedule();
    schedule = await this.getEntity(schedule, id);
    return schedule;
  }

  @override
  Future<Target> getTarget(String id) async {
    var target = new Target();
    target = await this.getEntity(target, id);

    if (target.clientId != null) {
      var client = await this.getClient(target.clientId);
      target.client = client;
    }

    return target;
  }

  @override
  Future<Client> getClient(String id) async {
    var client = new Client();
    client = await this.getEntity(client, id);
    return client;
  }

  @override
  Future<List<ServiceKitTemplate>> getServiceKitTemplateByJobSubType(
      String jobSubTypeId) async {
    var serviceKitTemplate = new ServiceKitTemplate();
    var serviceKitTemplateMaps = await _getList(serviceKitTemplate.tableName,
        whereClause: 'jobSubTypeId = ?', parameters: [jobSubTypeId]);
    List<ServiceKitTemplate> serviceKitTemplates = new List();
    for (var serviceKitTemplateMap in serviceKitTemplateMaps) {
      serviceKitTemplate = new ServiceKitTemplate();
      serviceKitTemplate.fromMap(serviceKitTemplateMap);
      serviceKitTemplates.add(serviceKitTemplate);
    }
    return serviceKitTemplates;
  }

  @override
  Future<List<ServiceKitTemplateItems>> getServiceKitTemplateItemsByTemplateId(
      String serviceKitTemplateId) async {
    var serviceKitTemplateItem = new ServiceKitTemplateItems();
    var serviceKitTemplateItemMaps = await _getList(
        serviceKitTemplateItem.tableName,
        whereClause: 'serviceKitTemplateId = ?',
        parameters: [serviceKitTemplateId]);
    List<ServiceKitTemplateItems> serviceKitTemplateItems = new List();
    print('___serviceKitTemplateItemMaps: $serviceKitTemplateItemMaps');
    for (var serviceKitTemplateItemMap in serviceKitTemplateItemMaps) {
      serviceKitTemplateItem = new ServiceKitTemplateItems();
      serviceKitTemplateItem.fromMap(serviceKitTemplateItemMap);
      serviceKitTemplateItems.add(serviceKitTemplateItem);
    }
    return serviceKitTemplateItems;
  }

  @override
  Future<Employee> getAccount({String username, String password}) async {
    var user = new User();
    var employee = new Employee();

    var userMap =
        await this._get(user.tableName, whereClause: 'email = ?', id: username);
    if (userMap == null) {
      userMap = await this
          ._get(user.tableName, whereClause: 'login = ?', id: username);
    }

    if (userMap != null) {
      user.fromMap(userMap);

      var employeeMap = await this
          ._get(employee.tableName, whereClause: 'id = ?', id: user.id);
      employee.fromMap(employeeMap);
      employee.user = user;
    } else {
      return null;
    }

//    var value = await this._get(user.tableName,
//        whereClause: 'id = ?', id: user.id);
//    user.fromMap(value);

    return employee;
  }
}
