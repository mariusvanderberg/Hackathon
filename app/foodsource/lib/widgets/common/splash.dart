import 'package:flutter/material.dart';
import 'dart:async';
import 'package:foodsource/pages/login.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen();

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
            () => Navigator.pushReplacement(
            context,
            new MaterialPageRoute(
                builder: (context) => LoginPage(title: "Mobile ERP"))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.yellow,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                //child: new FieldCheckTextLogo(),
                child: new Text('logo here')
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      backgroundColor: Colors.yellowAccent,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
