import 'package:enumeration/enumeration.dart';

class JobActionsEnum extends Enum {
  const JobActionsEnum(name, value) : super(name, value);

  static const JobActionsEnum SCHEDULE = const JobActionsEnum("Schedule", 0);
  static const JobActionsEnum START = const JobActionsEnum("Start", 1);
  static const JobActionsEnum REVIEW = const JobActionsEnum("Review", 2);
  static const JobActionsEnum COMPLETE = const JobActionsEnum("Complete", 3);
  static const JobActionsEnum FINALISE = const JobActionsEnum("Finalise", 4);

  String toString() => name;
}
