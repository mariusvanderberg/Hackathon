import 'package:foodsource/enums/filter_operator_enum.dart';

class Filter {
  final String fieldName;
  final String value;
  final FilterOperator operator;

  const Filter(this.fieldName, this.value,
      {this.operator = FilterOperator.EQUALS});
}


/*
class FilterList  {
  List<Filter> filters = new List();

  void add(Filter filter) => this.filters.add(filter);
  void addRange(List<Filter> filters) => this.filters.addAll(filters);

}
*/