import 'package:foodsource/common/colors.dart';
import 'package:foodsource/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:foodsource/widgets/common/logo.dart';

class About extends StatefulWidget {
  About({Key key, this.title}) : super(key: key);
  final String title;

  @override
  AboutState createState() => new AboutState();
}

class AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    TextStyle mainLabel = new TextStyle(
      debugLabel: 'blackMountainView mainlabel',
      fontFamily: 'Roboto',
      fontSize: 36.0,
      inherit: true,
      color: kAppTextDark,
      decoration: TextDecoration.none,);

    var descLabel = mainLabel.copyWith(color: kAppTextLight, fontSize: 22.0);
    final constants = Constants();
    var _dbVersion = constants.dbVersion;
    final String _version = constants.appVersion;

    Widget _createLabel(String txt, {int maxLines}) {
      return new Text(txt, style: descLabel, maxLines: maxLines == null ? 1 : maxLines, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center);
    }

    double _sidePadding = 10.0;

    return Scaffold(
      appBar: new AppBar(title: new Text('About')),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new TextField(
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                  new EdgeInsets.symmetric(horizontal: _sidePadding),
                ),
                enabled: false,
                textAlign: TextAlign.center,
                controller: new TextEditingController(
                  text: constants.appName,
                ),
                style: mainLabel,
              ),
              _createLabel("Version: $_version\nDatabase version: $_dbVersion",
                  maxLines: 2),
              new Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              new AppTextLogo(),
              new Padding(
                padding: EdgeInsets.only(top: 10.0),
              ),
              _createLabel(
                  "© ${DateTime.now().year.toString()} FoodSource Applications.\nAll rights reserved.",
                  maxLines: 2),
            ],
          )
        ],
      ),
    );
  }
}
