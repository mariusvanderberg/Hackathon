import 'package:foodsource/enums/checklist_item_answer_enum.dart';
import 'package:foodsource/models/base_entity.dart';
import 'package:foodsource/models/section.dart';

class Question extends BaseEntity {
  @override
  get tableName => 'Questions';
  @override
  get apiResourceName => 'questions';

  Section section = new Section();
  String sectionId;
  String name;
  int ordering;
  String type;
  ChecklistItemAnswer answer = ChecklistItemAnswer.NOTANSWERED;

  @override
  Map<String, dynamic> toMap() {
    super.toMap();
    super.map['name'] = name;
    super.map['order'] = ordering;
    super.map['type'] = type;
    super.map['sectionId'] = sectionId;

    if (section != null) {
      super.map['section'] = section.toMap();
    }
    
    return map;
  }

  @override
  fromMap(Map map) {
    super.fromMap(map);
    name = map['name'];
    ordering = map['order'];
    type = map['type'];

    if (map.containsKey('section') && map['section'] != null) {
      var sectionMap = map['section'];
      section = new Section();
      section.fromMap(sectionMap);
      sectionId = section.id;
    }

    if (map.containsKey('sectionId')) {
      sectionId = map['sectionId'];
      section.id = sectionId;
    }

    if (map.containsKey('answer') && map['answer'] != null) {
      answer = answer.valueOf(map['answer']);
    }
  }
}
