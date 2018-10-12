import 'package:foodsource/enums/xpedia_enum.dart';

class JobStatusEnum extends XpediaEnum {
  const JobStatusEnum(name, value, stringValue)
      : super(name, value, stringValue);

  static const JobStatusEnum NEW = const JobStatusEnum("New", 0, 'NEW');
  static const JobStatusEnum APPROVED =
      const JobStatusEnum("Approved", 1, 'APPROVED');
  static const JobStatusEnum ASSIGNED =
      const JobStatusEnum("Assigned", 2, 'ASSIGNED');
  static const JobStatusEnum NOTSTARTED =
      const JobStatusEnum("Not Started", 3, 'NOTSTARTED');
  static const JobStatusEnum SCHEDULED =
      const JobStatusEnum("Scheduled", 4, 'SCHEDULED');
  static const JobStatusEnum PENDING =
      const JobStatusEnum("Pending", 5, 'PENDING');
  static const JobStatusEnum INPROGRESS =
      const JobStatusEnum("In-Progress", 6, 'INPROGRESS');
  static const JobStatusEnum COMPLETED =
      const JobStatusEnum("Completed", 7, 'COMPLETED');
  static const JobStatusEnum CANCELLED =
      const JobStatusEnum("Cancelled", 8, 'CANCELLED');
  static const JobStatusEnum REVIEW =
      const JobStatusEnum("Reviewing", 9, 'REVIEW');
  static const JobStatusEnum FINALISED =
      const JobStatusEnum("Finalised", 10, 'FINALISED');
  static const JobStatusEnum INVOICED =
      const JobStatusEnum("Invoiced", 11, 'INVOICED');
  static const JobStatusEnum CLOSED =
      const JobStatusEnum("Closed", 12, 'CLOSED');

  static const List<XpediaEnum> values = const [
    NEW,
    APPROVED,
    ASSIGNED,
    NOTSTARTED,
    SCHEDULED,
    PENDING,
    INPROGRESS,
    COMPLETED,
    CANCELLED,
    REVIEW,
    FINALISED,
    INVOICED,
    CLOSED
  ];

  @override
  XpediaEnum valueOf(String name) =>
      values.singleWhere((val) => val.stringValue == name);

  String toString() => name;
}
