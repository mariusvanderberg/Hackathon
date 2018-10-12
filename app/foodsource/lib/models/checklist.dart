import 'package:foodsource/models/base_entity.dart';
import 'package:foodsource/models/client.dart';
import 'package:foodsource/models/client_group.dart';
import 'package:foodsource/models/section.dart';
import 'package:foodsource/models/target.dart';

class Checklist extends BaseEntity {
  @override
  get tableName => 'Checklists';
  @override
  get apiResourceName => 'checklists';

  String name;
  bool mandatory = false;
  int priority;

  String targetId;
  Target target = new Target();

  String clientId;
  Client client = new Client();

  String clientGroupId;
  ClientGroup clientGroup = new ClientGroup();

  List<Section> sections = new List<Section>();

  @override
  Map<String, dynamic> toMap() {
    super.toMap();
    super.map['name'] = name;
    super.map['mandatory'] = mandatory;
    super.map['priority'] = priority;

//    if (sections != null) {
//      List<Section> currentSections = new List<Section>();
//      sections.forEach((Section s) {
//        //var thisSection = s.toMap();
//        currentSections.add(s);
//      });
//      map['sections'] = currentSections;
//    }

    return map;
  }

  @override
  fromMap(Map map) {
    super.fromMap(map);
    name = map['name'];
    mandatory = map['mandatory'] == 1;
    priority = map['priority'];

//    if (map.containsKey('sections') && map['sections'] != null) {
//      var sectionsMap = map['sections'];
//      if (sections == null) {
//        sections = new List<Section>();
//      }
//
//      sectionsMap.forEach((sectionMap) {
//        Section section = new Section();
//        section.fromMap(sectionMap);
//        sections.add(section);
//      });
//    }
  }
}
