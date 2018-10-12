import 'dart:async';
import 'package:foodsource/exceptions/server_exception.dart';
import 'package:foodsource/common/api.dart';
import 'package:foodsource/models/address.dart';
import 'package:foodsource/models/base_entity.dart';
import 'package:foodsource/models/section.dart';
import 'package:foodsource/models/client.dart';
import 'package:foodsource/models/images.dart';
import 'package:foodsource/models/job.dart';
import 'package:foodsource/models/checklist.dart';
import 'package:foodsource/models/employee.dart';
import 'package:foodsource/models/schedule.dart';
import 'package:foodsource/models/service_kit_template.dart';
import 'package:foodsource/models/service_kit_template_items.dart';
import 'package:foodsource/models/target.dart';
import 'package:foodsource/models/user.dart';
import 'package:foodsource/models/user_comment.dart';
import 'package:foodsource/repository/filter.dart';
import 'package:foodsource/repository/i_repository.dart';

class RestRepository extends IRepository<BaseEntity> {
  //@override
  Future<Map> _get(String name, {String id, List<Filter> filters}) async {
    Api api = new Api();
    if (id != null && id != '') {
      return api.get(name, id: id, filters: filters);
    }

    return api.get(name);
  }

  Future<Map> _post(String name, Map data, bool isChanged) async {
    Api api = new Api();
    var returnValue = api.post(name, data);
    return returnValue;
  }

  Future<Map> _put(BaseEntity entity, bool isChanged) async {
    Api api = new Api();
    Map data = entity.toMap();
    return api.update(entity, data);
  }

  // Future<List<Map>> getListId(String name, {String id}) async {
  //   Api api = new Api();
  //   if (id != null && id != '') {
  //     return api.getList(name, id: id);
  //   }

  //   return api.getList(name);
  // }

  //@override
  Future<List<Map>> getList(String name,
      {String id, List<Filter> filters}) async {
    Api api = new Api();
    return await api.getList(name, id: id, filters: filters);
  }

  @override
  Future<BaseEntity> save(BaseEntity entity, bool isChanged) async {
    var returnedMap = await _put(entity, isChanged);
    if (returnedMap == null) {
      return null;
    }
    entity.fromMap(returnedMap);
    return entity;
  }

  @override
  Future<List<BaseEntity>> saveList(
      List<BaseEntity> entities, bool isChanged) async {
    var newEntitiesList = new List<BaseEntity>();
    for (var item in entities) {
      var returnedEntity = await save(item, false);
      newEntitiesList.add(returnedEntity);
    }
    return newEntitiesList;
  }

  @override
  Future<String> login(String username, String password) async {
    try {
      Api api = new Api();
      bool hasConnection = await api.testConnection();
      if (!hasConnection) {
        throw ServerException(
            'Cannot connect to authentication controller', null);
      }

      var returnValue = api.login(username: username, password: password);
      return returnValue;
    } on ServerException catch (ex) {
      throw ex;
    }
  }

  @override
  Future<Job> getJob(String id) async {
    var job = new Job();
    var value = await this._get(job.apiResourceName, id: id);
    if (value == null) return null;

    job.fromMap(value);
    return job;
  }

  @override
  Future<List<Job>> getJobs([String employeeId]) async {
    var job = new Job();
    print('Filtering for employee with ID: $employeeId');
    var values = await this.getList(job.apiResourceName,
        filters: [new Filter('employeeId', employeeId)]);

//    var values = await this.getList(job.apiResourceName);

    if (values == null) return null;

    List<Job> jobs = new List();
    for (int cnt = 0; cnt < values.length; cnt++) {
      job = new Job();
      job.fromMap(values[cnt]);
      jobs.add(job);
    }
    return jobs;
  }

  Future<Job> saveJob(Job job) async {
    var returnedJob = await save(job, false);
    return returnedJob;
  }

  @override
  Future<Employee> getEmployeeByUsername(String username,
      {String password}) async {
    var value =
        await this.getList('users', filters: [new Filter('login ', username)]);
    print('Loging in as: $username');
    if (value == null || value.length == 0) value = await this.getList('users');

    if (value == null || value.length == 0) return null;

    var employee = new Employee();
    employee.fromMap(value.first);

    if (password != null && employee.user != null) {
      employee.user.localPassword = password;
    }

    return employee;
  }

  @override
  Future<List<Checklist>> getChecklists() async {
    var checklist = new Checklist();
    var values = await this.getList(checklist.apiResourceName);
    if (values == null) return null;

    List<Checklist> lstChecklist = new List();
    for (int cnt = 0; cnt < values.length; cnt++) {
      checklist = new Checklist();
      checklist.fromMap(values[cnt]);
      lstChecklist.add(checklist);
    }
    return lstChecklist;
  }

  @override
  Future<Checklist> getChecklist(String id) async {
    var checklist = new Checklist();
    var value = await this._get(checklist.apiResourceName, id: id);
    if (value == null) {
      return null;
    }

    checklist.fromMap(value);

    return checklist;
  }

  @override
  Future<List<Section>> getSectionsByCheckListId(
      String checklistId) async {
    var section = new Section();
    var values = await this.getList(section.apiResourceName,
        filters: [new Filter("checklistId", checklistId)]);
    if (values == null) return null;

    List<Section> lstSections = new List();
    for (int cnt = 0; cnt < values.length; cnt++) {
      section = new Section();
      section.fromMap(values[cnt]);
      lstSections.add(section);
    }
    return lstSections;
  }

  @override
  Future<List<Checklist>> getChecklistsByJobId(String jobId) async {
    return getChecklists();
  }

  @override
  Future<List<UserComment>> getUserComments() async {
    var userComment = new UserComment();
    var values = await getList(userComment.apiResourceName);
    if (values == null) return null;

    List<UserComment> userComments = new List();
    for (int cnt = 0; cnt < values.length; cnt++) {
      userComment = new UserComment();
      userComment.fromMap(values[cnt]);
      userComments.add(userComment);
    }
    return userComments;
  }

  @override
  Future<UserComment> getUserComment(String id) async {
    var userComment = new UserComment();
    var value = await this._get(userComment.apiResourceName, id: id);
    if (value == null) {
      return null;
    }

    userComment.fromMap(value);

    return userComment;
  }

  @override
  Future<List<UserComment>> getUserCommentByJobId(String jobId) async {
    var userComment = new UserComment();
    var values = await getList(userComment.apiResourceName,
        filters: [new Filter("jobId", jobId)]);
    if (values == null) return null;

    List<UserComment> userComments = new List();
    for (int cnt = 0; cnt < values.length; cnt++) {
      userComment = new UserComment();
      userComment.fromMap(values[cnt]);
      userComments.add(userComment);
    }
    return userComments;
  }

  @override
  Future<Address> getAddress(String id) async {
    var address = new Address();
    var value = await this._get(address.apiResourceName, id: id);
    if (value == null) return null;

    address.fromMap(value);
    return address;
  }

  @override
  Future<Employee> getEmployee(String id) async {
    var employee = new Employee();
    var value = await this._get(employee.apiResourceName, id: id);
    if (value == null) return null;

    employee.fromMap(value);
    return employee;
  }

  @override
  Future<Schedule> getSchedule(String id) async {
    var schedule = new Schedule();
    var value = await this._get(schedule.apiResourceName, id: id);
    if (value == null) return null;

    schedule.fromMap(value);
    return schedule;
  }

  @override
  Future<Target> getTarget(String id) async {
    var target = new Target();
    var value = await this._get(target.apiResourceName, id: id);
    if (value == null) return null;

    target.fromMap(value);
    return target;
  }

  @override
  Future<Client> getClient(String id) async {
    var client = new Client();
    var value = await this._get(client.apiResourceName, id: id);
    if (value == null) return null;

    client.fromMap(value);
    return client;
  }

  @override
  Future<List<Images>> getImagesByJobId(String jobId) async {
    var jobImage = new Images();
    var values = await getList(jobImage.apiResourceName,
        filters: [new Filter("jobId", jobId)]);
    if (values == null) return null;

    List<Images> jobImages = new List();
    for (int cnt = 0; cnt < values.length; cnt++) {
      jobImage = new Images();
      jobImage.fromMap(values[cnt]);
      jobImages.add(jobImage);
    }
    return jobImages;
  }

  @override
  Future<List<ServiceKitTemplate>> getServiceKitTemplateByJobSubType(
      String jobSubTypeId) async {
    var serviceKitTemplate = new ServiceKitTemplate();
    var values = await getList(serviceKitTemplate.apiResourceName,
        filters: [new Filter("jobSubTypeId", jobSubTypeId)]);
    if (values == null) return null;

    List<ServiceKitTemplate> serviceKitTemplates = new List();
    for (int cnt = 0; cnt < values.length; cnt++) {
      serviceKitTemplate = new ServiceKitTemplate();
      serviceKitTemplate.fromMap(values[cnt]);
      serviceKitTemplates.add(serviceKitTemplate);
    }
    return serviceKitTemplates;
  }

  @override
  Future<List<ServiceKitTemplateItems>> getServiceKitTemplateItemsByTemplateId(
      String serviceKitTemplateId) async {
    var serviceKitTemplateItem = new ServiceKitTemplateItems();
    var values = await getList(serviceKitTemplateItem.apiResourceName,
        filters: [new Filter("serviceKitTemplateId", serviceKitTemplateId)]);
    if (values == null) return null;

    List<ServiceKitTemplateItems> serviceKitTemplateItems = new List();
    for (int cnt = 0; cnt < values.length; cnt++) {
      serviceKitTemplateItem = new ServiceKitTemplateItems();
      serviceKitTemplateItem.fromMap(values[cnt]);
      serviceKitTemplateItems.add(serviceKitTemplateItem);
    }
    return serviceKitTemplateItems;
  }

  @override
  Future<Employee> getAccount({String username, String password}) async {
    var user = new User();
    var employee = new Employee();
    var value = await this._get('account');
    if (value == null) return null;

    try {
      user.fromMap(value);
      employee.userId = user.id;
      employee.fromMap(value);
      employee.user = user;
    } on Exception catch (exc) {
      print('Unable to map user: $exc');
    }

    if (password != null && employee.user != null) {
      employee.user.localPassword = password;
    }

    return employee;
  }
}
