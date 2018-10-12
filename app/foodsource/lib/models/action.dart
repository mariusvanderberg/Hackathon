import 'package:foodsource/models/base_entity.dart';

class Action extends BaseEntity {
  @override
  get tableName => 'Actions';
  @override
  get apiResourceName => 'Actions';

  int priority;
  String name;
}
