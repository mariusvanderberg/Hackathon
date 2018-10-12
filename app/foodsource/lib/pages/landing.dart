import 'package:foodsource/common/session.dart';
import 'package:foodsource/pages/about.dart';
import 'package:foodsource/pages/initiator.dart';
import 'package:foodsource/pages/profile/profile.dart';
import 'package:foodsource/enums/drawer_item_enum.dart';
import 'package:foodsource/pages/login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DrawerItem {
  String title;
  IconData icon;

  DrawerItem(this.title, this.icon, this.drawerItemType, this.drawerWidget);

  DrawerItemEnum drawerItemType;
  Widget drawerWidget;
}

class LandingPage extends StatefulWidget {
  final String title;

  LandingPage({Key key, this.title}) : super(key: key);

  @override
  LandingPageState createState() => new LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  DrawerItem _selectedDrawerItem;
  static var employee = Session().employee;
  var user = employee.user;

  _onSelectItem(DrawerItem d) {
    switch (d.drawerItemType) {
      case DrawerItemEnum.LOGOUT:
        Session().clearData();
        Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(
                builder: (context) => new LoginPage(title: widget.title)),
            (Route<dynamic> route) => false);
        break;
      case DrawerItemEnum.PROFILE:
        _navigateTo(new ProfileDetails(Session().employee.user,
            avatarTag: 'assets/images/goku.png'));
        break;
      case DrawerItemEnum.ABOUT:
        _navigateTo(new About());
        break;
      default:
        setState(() => _selectedDrawerItem = d);
        Navigator.of(context).pop(); // close the drawer
    }
    if (d.drawerItemType == DrawerItemEnum.LOGOUT) {}
  }

  void _navigateTo(page) {
    Navigator.of(context).pop(); // close the drawer
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) => page));
  }

  var drawerItems = [
    new DrawerItem(
        "Welcome, $employee", Icons.work, DrawerItemEnum.HOME, MainPage()),
    new DrawerItem(
        "Profile",
        Icons.perm_identity,
        DrawerItemEnum.PROFILE,
        new ProfileDetails(Session().employee.user,
            avatarTag: 'assets/images/goku.png')),
    new DrawerItem(
        "About", Icons.info_outline, DrawerItemEnum.ABOUT, new About()),
    new DrawerItem(
        "Log out", Icons.exit_to_app, DrawerItemEnum.LOGOUT, new LoginPage())
  ];

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    if (_selectedDrawerItem == null) {
      _selectedDrawerItem = drawerItems[0];
    }

    for (var i = 0; i < drawerItems.length; i++) {
      var d = drawerItems[i];
      drawerOptions.add(
        new ListTile(
          leading: new Icon(d.icon),
          title: new Text(d.title),
          selected: _selectedDrawerItem.title == d.title,
          onTap: () => _onSelectItem(d),
        ),
      );
      drawerOptions.add(
        new Divider(),
      );
    }

    return new Scaffold(
      drawer: new Drawer(
        child: new ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            new UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
                backgroundBlendMode: BlendMode.darken,
                shape: BoxShape.rectangle,
                border: Border(right: BorderSide(color: Colors.red, width: 0.0)),
                gradient: new LinearGradient(
                  // new
                  // Where the linear gradient begins and ends
                  begin: Alignment.topRight, // new
                  end: Alignment.bottomLeft, // new
                  // Add one stop for each color.
                  // Stops should increase
                  // from 0 to 1
                  stops: [0.1, 0.5, 0.7, 0.9],
                  colors: [
                    // Colors are easy thanks to Flutter's
                    // Colors class.
                    Colors.indigo,
                    Colors.green[700],
                    Colors.green,
                    Colors.green[400],
                  ],
                ),
              ),
              accountName: new Text(employee.displayName),
              accountEmail: new Text(user.email),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: new AssetImage('assets/images/goku.png'),
              ),
            ),
            new Column(
              children: drawerOptions,
            )
          ],
        ),
      ),
      body: _selectedDrawerItem.drawerWidget,
    );
  }
}
