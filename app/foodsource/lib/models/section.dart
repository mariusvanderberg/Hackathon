import 'package:foodsource/models/base_entity.dart';
import 'package:foodsource/models/checklist.dart';

class Section extends BaseEntity {
  @override
  get tableName => 'Sections';
  @override
  get apiResourceName => 'sections';

  Checklist checklist = new Checklist();
  String name;
  int ordering;
  String checklistId;
  //ChecklistItemAnswer answer = ChecklistItemAnswer.NOTANSWERED;

  @override
  Map<String, dynamic> toMap() {
    super.toMap();
    super.map['name'] = name;
    super.map['checklistId'] = checklistId;
    super.map['order'] = ordering;

    if (checklist != null) {
      super.map['checklist'] = checklist.toMap();
    }

    return map;
  }

  @override
  fromMap(Map map) {
    super.fromMap(map);
    name = map['name'];
    ordering = map['order'];

    if (map.containsKey('checklist') && map['checklist'] != null) {
      var checklistMap = map['checklist'];
      checklist = new Checklist();
      checklist.fromMap(checklistMap);
      checklistId = checklist.id;
    }

    if (map.containsKey('checklistId')) {
      checklistId = map['checklistId'];
      checklist.id = checklistId;
    }

//    if (map.containsKey('answer') && map['answer'] != null) {
//      answer = answer.valueOf(map['answer']);
//    }
  }
}
