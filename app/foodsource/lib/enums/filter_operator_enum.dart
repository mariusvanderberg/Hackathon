import 'package:foodsource/enums/xpedia_enum.dart';

class FilterOperator extends XpediaEnum {
  const FilterOperator(name, value, stringValue)
      : super(name, value, stringValue);

  static const FilterOperator EQUALS =
      const FilterOperator("Equals", 0, 'equals');

  static const List<FilterOperator> values = const [EQUALS];

  @override
  FilterOperator valueOf(String name) =>
      values.singleWhere((val) => val.stringValue == name);

  String toString() => name;
}
