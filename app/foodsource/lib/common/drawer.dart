import 'package:flutter/material.dart';
import 'package:foodsource/enums/drawer_item_enum.dart';

class DrawerItem {
  String title;
  IconData icon;

  DrawerItem(this.title, this.icon, this.drawerItemType, this.drawerWidget);

  DrawerItemEnum drawerItemType;
  Widget drawerWidget;
}