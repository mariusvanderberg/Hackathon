import 'package:flutter/material.dart';
import 'package:foodsource/constants/constants.dart';

class AppTextLogo extends StatelessWidget {
  AppTextLogo();

  final constants = Constants();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Image(
              image: new AssetImage("assets/images/apple.png"),
              width: 120.0,
              height: 120.0),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
          ),
          Text(
            constants.appName,
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20.0,
              fontWeight: FontWeight.normal,
            ),
            overflow: TextOverflow.fade,
          ),
        ],
      ),
    );
  }
}

class AppLogo extends StatelessWidget {
  AppLogo();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 50.0,
            child: Icon(Icons.verified_user, color: Colors.white, size: 70.0),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
          ),
        ],
      ),
    );
  }
}
