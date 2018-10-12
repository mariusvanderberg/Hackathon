import 'dart:async';
import 'package:foodsource/exceptions/not_implemented_exception.dart';
import 'package:foodsource/models/address.dart';
import 'package:foodsource/models/checklist.dart';
import 'package:foodsource/models/section.dart';
import 'package:foodsource/models/client.dart';
import 'package:foodsource/models/job.dart';
import 'package:foodsource/models/base_entity.dart';
import 'package:foodsource/models/employee.dart';
import 'package:foodsource/models/images.dart';
import 'package:foodsource/models/schedule.dart';
import 'package:foodsource/models/service_kit_template.dart';
import 'package:foodsource/models/service_kit_template_items.dart';
import 'package:foodsource/models/target.dart';
import 'package:foodsource/models/user_comment.dart';

abstract class IRepository<T extends BaseEntity> {
  //Future<List<dynamic>> getList(String entityName);
  Future<T> save(T entity, bool isChanged);

  Future<List<T>> saveList(List<T> entities, bool isChanged);

  // Future<Job> getJob(String id) async {
  //   return null;
  // }

  Future<Employee> getAccount({String username, String password}) {
    throw new NotImplementedException(
        'getAccount on IRepository not implemented');
  }

  Future<Employee> getEmployee(String id) {
    throw new NotImplementedException(
        'getEmployee on IRepository not implemented');
  }

  Future<Employee> getEmployeeByUsername(String username, {String password}) {
    throw new NotImplementedException(
        'getEmployeeByUsername on IRepository not implemented');
  }

  Future<String> login(String username, String password) {
    throw new NotImplementedException(
        'getUserAccount on IRepository not implemented');
  }

  Future<Job> getJob(String id) {
    throw new NotImplementedException('getJobs on IRepository not implemented');
  }

  Future<List<Job>> getJobs([String employeeId]) {
    throw new NotImplementedException('getJobs on IRepository not implemented');
  }

  Future<List<Checklist>> getChecklists() {
    throw new NotImplementedException(
        'getChecklists on IRepository not implemented');
  }

  Future<Checklist> getChecklist(String id) {
    throw new NotImplementedException(
        'getChecklists on IRepository not implemented');
  }

  Future<List<Checklist>> getChecklistsByJobId(String jobId) {
    throw new NotImplementedException(
        'getChecklistsByJobId on IRepository not implemented');
  }

  Future<List<Section>> getSectionsByCheckListId(String id) {
    throw new NotImplementedException(
        'getSectionsByCheckListId on IRepository not implemented');
  }

  Future<List<Section>> getQuestionsBySectionId(String id) {
    throw new NotImplementedException(
        'getQuestionsBySectionId on IRepository not implemented');
  }

  Future<List<Checklist>> getChecklistsByTargetId(String targetId) {
    throw new NotImplementedException(
        'getChecklistsByTargetId on IRepository not implemented');
  }

  Future<List<Checklist>> getChecklistsByClientId(String clientId) {
    throw new NotImplementedException(
        'getChecklistsByClientId on IRepository not implemented');
  }

  Future<List<Checklist>> getChecklistsByClientGroupId(String clientGroupId) {
    throw new NotImplementedException(
        'getChecklistsByClientGroupId on IRepository not implemented');
  }

  Future<Images> getImage(String id) {
    throw new NotImplementedException(
        'getImage on IRepository not implemented');
  }

  Future<List<Images>> getImagesByJobId(String jobId) {
    throw new NotImplementedException(
        'getImagesByJobId on IRepository not implemented');
  }

  Future<List<UserComment>> getUserComments() {
    throw new NotImplementedException(
        'getUserNotes on IRepository not implemented');
  }

  Future<UserComment> getUserComment(String id) {
    throw new NotImplementedException(
        'getUserNote on IRepository not implemented');
  }

  Future<List<UserComment>> getUserCommentByJobId(String jobId) {
    throw new NotImplementedException(
        'getUserNoteByJobId on IRepository not implemented');
  }

  Future<Address> getAddress(String id) {
    throw new NotImplementedException(
        'getAddress on IRepository not implemented');
  }

  Future<Schedule> getSchedule(String id) {
    throw new NotImplementedException(
        'getSchedule on IRepository not implemented');
  }

  Future<Target> getTarget(String id) {
    throw new NotImplementedException(
        'getTarget on IRepository not implemented');
  }

  Future<Client> getClient(String id) {
    throw new NotImplementedException(
        'getClient on IRepository not implemented');
  }

  Future<List<ServiceKitTemplate>> getServiceKitTemplateByJobSubType(
      String jobId) {
    throw new NotImplementedException(
        'getServiceKitTemplateByJobSubType on IRepository not implemented');
  }

  Future<List<ServiceKitTemplateItems>> getServiceKitTemplateItemsByTemplateId(
      String serviceKitTemplateId) {
    throw new NotImplementedException(
        'getServiceKitTemplateItemsByTemplateId on IRepository not implemented');
  }

//  Future<List<ServiceKitUsed>> getServiceKitUsedByJobSubType(
//      String jobId) {
//    throw new NotImplementedException(
//        'getServiceKitUsedByJobSubType on IRepository not implemented');
//  }
//
//  Future<List<ServiceKitItemsUsed>> getServiceKitItemsUsedByServiceKitUsedId(
//      String serviceKitUsedId) {
//    throw new NotImplementedException(
//        'getServiceKitItemsUsedByServiceKitUsedId on IRepository not implemented');
//  }
}
