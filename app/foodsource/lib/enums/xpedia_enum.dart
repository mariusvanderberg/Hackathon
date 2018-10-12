abstract class XpediaEnum {
  final int val;
  final String name;
  final String stringValue;
  const XpediaEnum(this.name, [this.val, this.stringValue]);

  static const List<XpediaEnum> values = [];

  XpediaEnum valueOf(String name) =>
      values.singleWhere((val) => val.stringValue == stringValue);

  fromInt(int i) => values.singleWhere((val) => val.val == i);
}
