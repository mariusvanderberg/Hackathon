import 'package:foodsource/enums/xpedia_enum.dart';

class ChecklistItemAnswer extends XpediaEnum{
  const ChecklistItemAnswer(name, value, stringValue) : super(name, value, stringValue);

  static const ChecklistItemAnswer NO = const ChecklistItemAnswer("No",0, 'NO');
  static const ChecklistItemAnswer NOTANSWERED = const ChecklistItemAnswer("Not Answered",1,'NOTANSWERED');
  static const ChecklistItemAnswer YES = const ChecklistItemAnswer("Yes",2,'YES');

  static const List<XpediaEnum> values = const [NO, NOTANSWERED, YES];

  @override
  XpediaEnum valueOf(String name) => values.singleWhere((val) => val.stringValue == name);
  

  String toString() => name;
}
