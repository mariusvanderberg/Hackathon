import 'dart:async';
import 'package:foodsource/common/session.dart';
import 'package:foodsource/exceptions/not_implemented_exception.dart';
import 'package:foodsource/exceptions/server_exception.dart';
import 'package:foodsource/models/address.dart';
import 'package:foodsource/models/checklist.dart';
import 'package:foodsource/models/question.dart';
import 'package:foodsource/models/section.dart';
import 'package:foodsource/models/client.dart';
import 'package:foodsource/models/job.dart';
import 'package:foodsource/models/employee.dart';
import 'package:foodsource/models/base_entity.dart';
import 'package:foodsource/models/schedule.dart';
import 'package:foodsource/models/service_kit_template.dart';
import 'package:foodsource/models/service_kit_template_items.dart';
import 'package:foodsource/models/target.dart';
import 'package:foodsource/models/user.dart';
import 'package:foodsource/models/user_comment.dart';
import 'package:foodsource/repository/data_sync.dart';
import 'package:foodsource/repository/i_repository.dart';
import 'package:foodsource/repository/local_repository.dart';
import 'package:foodsource/repository/rest_repository.dart';
import 'package:foodsource/models/images.dart';

class Repository implements IRepository<BaseEntity> {
  IRepository<BaseEntity> _localRepository = new LocalRepository();
  IRepository<BaseEntity> _restRepository = new RestRepository();

  @override
  Future<Employee> getEmployeeByUsername(String username,
      {String password}) async {
    await DataSync().syncUp(new Employee());

    Employee employee = await _restRepository.getEmployeeByUsername(username);
    if (employee != null) {
      await _localRepository.save(employee, false);

      if (password != null) {
        employee.user.localPassword = password;
      }

      employee.user.accessToken = Session().accessToken;
      await _localRepository.save(employee.user, false);
      if (employee.company != null) {
        await _localRepository.save(employee.company, false);
      }
    }

    var localResponse = await _localRepository.getEmployeeByUsername(username,
        password: password);
    return localResponse;
  }

  @override
  Future<Job> getJob(String id) async {
    await DataSync().syncUp(new Job());

    Job job = await _restRepository.getJob(id);
    if (job != null) {
      await _localRepository.save(job, false);
    }

    job = await _localRepository.getJob(id);
    return job;
  }

  @override
  Future<List<Job>> getJobs([String employeeId]) async {
    await DataSync().syncUp(new Job());

    List<Job> jobs = new List<Job>();
    jobs = await _restRepository.getJobs(Session().employee.id);
    if (jobs != null) {
      for (var job in jobs) {
        await _localRepository.save(job, false);

        if (job.address != null) {
          await _localRepository.save(job.address, false);
        }

        if (job.target != null) {
          await _localRepository.save(job.target, false);

          // target address
          if (job.target.address != null) {
            await _localRepository.save(job.target.address, false);
          }
        }

        if (job.employee != null) {
          await _localRepository.save(job.employee, false);
        }
      }
    }

    jobs = await _localRepository.getJobs(employeeId);
    return jobs;
  }

  @override
  Future<Images> getImage(String id) async {
    await DataSync().syncUp(new Images());

    Images image = await _restRepository.getImage(id);
    if (image != null) {
      await _localRepository.save(image, false);
    }

    image = await _localRepository.getImage(id);
    return image;
  }

  @override
  Future<List<Images>> getImagesByJobId(String id) async {
    await DataSync().syncUp(new Images());

    List<Images> images = new List<Images>();
    images = await _restRepository.getImagesByJobId(id);
    if (images != null) {
      await _localRepository.saveList(images, false);
    }
    images = await _localRepository.getImagesByJobId(id);
    return images;
  }

  Future<List> getList(String entityName) async {
    throw new NotImplementedException('getList on repository not implemented');
  }

  @override
  Future<BaseEntity> save(BaseEntity entity, bool isChanged) async {
    entity = await _localRepository.save(entity, isChanged);
    var restEntity = await _restRepository.save(entity, isChanged);
    if (restEntity != null) {
      entity = await _localRepository.save(restEntity, false);
    }

    return entity;
  }

  @override
  Future<List<BaseEntity>> saveList(
      List<BaseEntity> entities, bool isChanged) async {
    entities = await _localRepository.saveList(entities, isChanged);
    var restEntities = await _restRepository.saveList(entities, isChanged);
    if (restEntities != null && restEntities.length == entities.length) {
      entities = await _localRepository.saveList(entities, false);
    }
    return entities;
  }

  @override
  Future<String> login(String username, String password) async {
    String token;
    try {
      print('authenticating...');
      token = await _restRepository.login(username, password);
    } on ServerException catch (ex) {
      print('ServerException: ${ex.message}');
      token = await _localRepository.login(username, password);
    }
    return token;
  }

  @override
  Future<List<Checklist>> getChecklists() async {
    await DataSync().syncUp(new Checklist());

    var checklists = await _restRepository.getChecklists();

    await parseChecklist(checklists);

    checklists = await _localRepository.getChecklists();
    return checklists;
  }

  @override
  Future<Checklist> getChecklist(String id) async {
    await DataSync().syncUp(new Checklist());

    var checklist = await _restRepository.getChecklist(id);
    if (checklist != null) {
      await _localRepository.save(checklist, false);
    }

    checklist = await _localRepository.getChecklist(id);
    return checklist;
  }

  @override
  Future<List<Checklist>> getChecklistsByJobId(String jobId) async {
    return new List<Checklist>();
//    await DataSync().syncUp(new Checklist());
//
//    var checklists = await _restRepository.getChecklistsByJobId(jobId);
//    if (checklists != null) {
//      await _localRepository.saveList(checklists, false);
//    }
//
//    checklists = await _localRepository.getChecklistsByJobId(jobId);
//    return checklists;
  }

  @override
  Future<List<Section>> getSectionsByCheckListId(
      String checklistId) async {
    await DataSync().syncUp(new Section());

    var sections =
        await _restRepository.getSectionsByCheckListId(checklistId);
    if (sections != null) {
      await _localRepository.saveList(sections, false);
    }

    sections =
        await _localRepository.getSectionsByCheckListId(checklistId);

    return sections;
  }

  Future<List<Section>> getQuestionsBySectionId(
      String sectionId) async {
    await DataSync().syncUp(new Section());

    var sections =
    await _restRepository.getQuestionsBySectionId(sectionId);
    if (sections != null) {
      await _localRepository.saveList(sections, false);
    }

    sections =
    await _localRepository.getQuestionsBySectionId(sectionId);

    return sections;
  }

  @override
  Future<List<Checklist>> getChecklistsByTargetId(String targetId) async {
    await DataSync().syncUp(new Checklist());

    List<Checklist> checklists = new List<Checklist>();
    checklists = await _restRepository.getChecklistsByTargetId(targetId);

    await parseChecklist(checklists);

    checklists = await _localRepository.getChecklistsByTargetId(targetId);
    return checklists;
  }

  @override
  Future<List<Checklist>> getChecklistsByClientId(String clientId) async {
    await DataSync().syncUp(new Checklist());

    List<Checklist> checklists = new List<Checklist>();
    checklists = await _restRepository.getChecklistsByClientId(clientId);

    await parseChecklist(checklists);

    checklists = await _localRepository.getChecklistsByClientId(clientId);
    return checklists;
  }

  @override
  Future<List<Checklist>> getChecklistsByClientGroupId(String clientGroupId) async {
    await DataSync().syncUp(new Checklist());

    List<Checklist> checklists = new List<Checklist>();
    checklists = await _restRepository.getChecklistsByClientGroupId(clientGroupId);

    await parseChecklist(checklists);

    checklists = await _localRepository.getChecklistsByClientGroupId(clientGroupId);
    return checklists;
  }

  Future<Null> parseChecklist(List<Checklist> checklists) async {
    if (checklists != null) {
      for (Checklist checklist in checklists) {
        await _localRepository.save(checklist, false);

        if (checklist.sections != null) {
          for (Section section in checklist.sections) {
            await _localRepository.save(section, false);

//            if (section.question != null) {
//              for (Question question in section.questions) {
//                await _localRepository.save(question, false);
//              }
//            }
          }
        }
      }
    }
  }

  @override
  Future<List<UserComment>> getUserComments() async {
    await DataSync().syncUp(new UserComment());

    var userComments = await _restRepository.getUserComments();
    if (userComments != null) {
      await _localRepository.saveList(userComments, false);
    }

    userComments = await _localRepository.getUserComments();
    return userComments;
  }

  @override
  Future<UserComment> getUserComment(String id) async {
    await DataSync().syncUp(new UserComment());

    var userComment = await _restRepository.getUserComment(id);
    if (userComment != null) {
      await _localRepository.save(userComment, false);
    }

    userComment = await _localRepository.getUserComment(id);
    return userComment;
  }

  @override
  Future<List<UserComment>> getUserCommentByJobId(String jobId) async {
    await DataSync().syncUp(new UserComment());

    var userComments = await _restRepository.getUserCommentByJobId(jobId);
    if (userComments != null) {
      await _localRepository.saveList(userComments, false);
    }

    userComments = await _localRepository.getUserCommentByJobId(jobId);
    return userComments;
  }

  @override
  Future<Address> getAddress(String id) async {
    await DataSync().syncUp(new Address());

    Address address = await _restRepository.getAddress(id);
    if (address != null) {
      await _localRepository.save(address, false);
    }

    address = await _localRepository.getAddress(id);
    return address;
  }

  @override
  Future<Employee> getEmployee(String id) async {
    await DataSync().syncUp(new Target());

    Employee employee = await _restRepository.getEmployee(id);
    if (employee != null) {
      await _localRepository.save(employee, false);
    }

    employee = await _localRepository.getEmployee(id);
    return employee;
  }

  @override
  Future<Schedule> getSchedule(String id) async {
    await DataSync().syncUp(new Schedule());

    Schedule schedule = await _restRepository.getSchedule(id);
    if (schedule != null) {
      await _localRepository.save(schedule, false);
    }

    schedule = await _localRepository.getSchedule(id);
    return schedule;
  }

  @override
  Future<Target> getTarget(String id) async {
    await DataSync().syncUp(new Target());

    Target target = await _restRepository.getTarget(id);
    if (target != null) {
      await _localRepository.save(target, false);
    }

    target = await _localRepository.getTarget(id);
    return target;
  }

  @override
  Future<Client> getClient(String id) async {
    await DataSync().syncUp(new Client());

    Client client = await _restRepository.getClient(id);
    if (client != null) {
      await _localRepository.save(client, false);
    }

    client = await _localRepository.getClient(id);
    return client;
  }

  @override
  Future<List<ServiceKitTemplate>> getServiceKitTemplateByJobSubType(
      String jobSubTypeId) async {
    await DataSync().syncUp(new ServiceKitTemplate());

    var serviceKitTemplates =
        await _restRepository.getServiceKitTemplateByJobSubType(jobSubTypeId);
    if (serviceKitTemplates != null) {
      await _localRepository.saveList(serviceKitTemplates, false);
    }

    serviceKitTemplates =
        await _localRepository.getServiceKitTemplateByJobSubType(jobSubTypeId);
    return serviceKitTemplates;
  }

  @override
  Future<List<ServiceKitTemplateItems>> getServiceKitTemplateItemsByTemplateId(
      String serviceKitTemplateId) async {
    await DataSync().syncUp(new ServiceKitTemplateItems());

    var serviceKitTemplateItems = await _restRepository
        .getServiceKitTemplateItemsByTemplateId(serviceKitTemplateId);
    print('___serviceKitTemplateItems rest: $serviceKitTemplateItems');
    if (serviceKitTemplateItems != null) {
      await _localRepository.saveList(serviceKitTemplateItems, false);
    }

    serviceKitTemplateItems = await _localRepository
        .getServiceKitTemplateItemsByTemplateId(serviceKitTemplateId);
    print('___serviceKitTemplateItems local: $serviceKitTemplateItems');
    return serviceKitTemplateItems;
  }

  @override
  Future<Employee> getAccount({String username, String password}) async {
    Employee employee = await _restRepository.getAccount(password: password); // no need to send the username when using rest repo
    if (employee != null) {
      print('Employee is not null, saving locally');
      await _localRepository.save(employee, false);

      employee.user.accessToken = Session().accessToken;
      await _localRepository.save(employee.user, false);
      if (employee.company != null) {
        await _localRepository.save(employee.company, false);
      }
    }

    var localResponse = await _localRepository.getAccount(username: username);

    while (localResponse == null) {
      print('Employee is null locally, calling getAccount again...');
      localResponse = await getAccount(username: username);
    }

    return localResponse;
  }
}
