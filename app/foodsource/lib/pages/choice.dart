import 'package:foodsource/common/colors.dart';
import 'package:foodsource/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:foodsource/pages/initiator.dart';
import 'package:foodsource/widgets/common/logo.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodsource/widgets/common/theme.dart';

class Choice extends StatefulWidget {
  Choice({Key key, this.title}) : super(key: key);
  final String title;

  @override
  ChoiceState createState() => new ChoiceState();
}

class ChoiceState extends State<Choice> {
  @override
  Widget build(BuildContext context) {
    TextStyle mainLabel = new TextStyle(
      debugLabel: 'blackMountainView mainlabel',
      fontFamily: 'Roboto',
      fontSize: 36.0,
      inherit: true,
      color: kAppTextDark,
      decoration: TextDecoration.none,
    );

    var descLabel = mainLabel.copyWith(color: kAppTextLight, fontSize: 22.0);
    final constants = Constants();
    var _dbVersion = constants.dbVersion;
    final String _version = constants.appVersion;

    Widget _createLabel(String txt, {int maxLines}) {
      return new Text(txt,
          style: descLabel,
          maxLines: maxLines == null ? 1 : maxLines,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center);
    }

    double _sidePadding = 10.0;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  constraints: BoxConstraints(minWidth: 150.0),
                  height: 82.0,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: new RaisedButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      elevation: 2.0,
                      color: Colors.green,
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Icon(
                            FontAwesomeIcons.signInAlt,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                          ),
                          Text('View market', style: buttonTextStyle)
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) => MainPage()));
                      })),
              Container(
                  constraints: BoxConstraints(minWidth: 150.0),
                  height: 82.0,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: new RaisedButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      elevation: 2.0,
                      color: Colors.green,
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Icon(
                            FontAwesomeIcons.signInAlt,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                          ),
                          Text('Sell', style: buttonTextStyle)
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) => MainPage()));
                      })),
              _createLabel("Version: $_version\nDatabase version: $_dbVersion",
                  maxLines: 2),
              new AppTextLogo(),
              _createLabel(
                  "© ${DateTime.now().year.toString()} Xpedia Applications.\nAll rights reserved.",
                  maxLines: 2),
            ],
          )
        ],
      ),
    );
  }
}
