import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodsource/common/session.dart';
import 'package:foodsource/pages/initiator.dart';
import 'package:foodsource/pages/landing.dart';
import 'package:foodsource/widgets/common/theme.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;
  double _size = 140.0;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 1000));
    _iconAnimation = new CurvedAnimation(
      parent: _iconAnimationController,
      curve: Curves.bounceOut,
    );
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final loginButton = Container(
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
                Text('Let' 's go!', style: buttonTextStyle)
              ],
            ),
            onPressed: () {
              _login();
            }));

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot your password?',
        style: TextStyle(color: Colors.white54),
      ),
      onPressed: () {},
    );

    final spacer = Padding(
      padding: const EdgeInsets.only(top: 60.0),
    );

    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Stack(fit: StackFit.expand, children: <Widget>[
        new Image(
          image: new AssetImage("assets/images/App.png"),
          fit: BoxFit.cover,
          colorBlendMode: BlendMode.darken,
          color: Colors.black87,
        ),
        new Theme(
            data: new ThemeData(
                brightness: Brightness.dark,
                inputDecorationTheme: new InputDecorationTheme(
                  // hintStyle: new TextStyle(color: Colors.blue, fontSize: 20.0),
                  labelStyle:
                      new TextStyle(color: Colors.white, fontSize: 25.0),
                )),
            isMaterialAppTheme: true,
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Image(
                          image: new AssetImage("assets/images/apple.png"),
                          width: _iconAnimation.value * _size,
                          height: _iconAnimation.value * 140.0),
                      new Container(
                        padding: const EdgeInsets.all(40.0),
                        child: new Form(
                          autovalidate: true,
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new TextFormField(
                                decoration: new InputDecoration(
                                    labelText: "Enter Email",
                                    fillColor: Colors.white),
                                keyboardType: TextInputType.emailAddress,
                              ),
                              new TextFormField(
                                decoration: new InputDecoration(
                                  labelText: "Enter Password",
                                ),
                                obscureText: true,
                                keyboardType: TextInputType.text,
                              ),
                              spacer,
                              loginButton,
                              forgotLabel
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )),
      ]),
    );
  }

  void _login() async {
    Session().employee = 'Marius';
    Navigator.pushReplacement(context,
        new MaterialPageRoute(builder: (context) => new LandingPage()));
  }

  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }
}
