import 'package:foodsource/enums/xpedia_enum.dart';

class JobButtonsEnum extends XpediaEnum {
  const JobButtonsEnum(name, value, stringValue)
      : super(name, value, stringValue);

  static const JobButtonsEnum COMMENTS = const JobButtonsEnum("Comments", 0, 'COMMENTS');
  static const JobButtonsEnum CAMERA = const JobButtonsEnum("Camera", 1, 'CAMERA');
  static const JobButtonsEnum HIDE = const JobButtonsEnum("Hide", 2, 'HIDE');
  static const JobButtonsEnum RESET = const JobButtonsEnum("Reset", 3, 'RESET');
  static const JobButtonsEnum GEOLOCATION = const JobButtonsEnum("Location", 4, 'GEOLOCATION');

  static const List<XpediaEnum> values = const [
    COMMENTS,
    CAMERA,
    HIDE,
    RESET,
    GEOLOCATION
  ];

  @override
  XpediaEnum valueOf(String name) =>
      values.singleWhere((val) => val.stringValue == name);

  String toString() => name;
}
