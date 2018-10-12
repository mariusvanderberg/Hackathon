import 'package:enumeration/enumeration.dart';

class DrawerItemEnum extends Enum {
  const DrawerItemEnum(name, value) : super(name, value);

  static const DrawerItemEnum HOME = const DrawerItemEnum("Home", 0);
  static const DrawerItemEnum PROFILE = const DrawerItemEnum("Profile", 3);
  static const DrawerItemEnum ABOUT = const DrawerItemEnum("About", 4);
  static const DrawerItemEnum LOGOUT = const DrawerItemEnum("Log out", 5);
}
