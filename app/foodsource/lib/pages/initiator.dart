import 'package:foodsource/common/diagonal_clipper.dart';
import 'package:foodsource/common/session.dart';
import 'package:foodsource/pages/tasks/animated_fab.dart';
import 'package:foodsource/pages/tasks/initial_tasks.dart';
import 'package:foodsource/pages/tasks/list_model.dart';
import 'package:foodsource/pages/tasks/task_row.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodsource/widgets/common/theme.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<AnimatedListState> _listKey =
  new GlobalKey<AnimatedListState>();
  final double _imageHeight = 256.0;
  ListModel listModel;
  bool showOnlyCompleted = false;
  bool showOptions = true;
  var titleA = 'Marketplace';

  @override
  void initState() {
    super.initState();
    listModel = new ListModel(_listKey, tasks);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          _buildTimeline(),
          _buildImage(),
          _buildTopHeader(),
          _buildProfileRow(),
          _buildBottomPart(),
          _buildFab(),
        ],
      ),
    );
  }

  Widget _buildFab() {
    return new Positioned(
        top: _imageHeight - 100.0,
        right: -40.0,
        child:new AnimatedFab(
          onClick: _changeFilterState,
        )
    );
  }

  void _changeFilterState() {
    showOnlyCompleted = !showOnlyCompleted;
    tasks.where((task) => !task.completed).forEach((task) {
      if (showOnlyCompleted) {
        listModel.removeAt(listModel.indexOf(task));
      } else {
        listModel.insert(tasks.indexOf(task), task);
      }
    });
  }

  Widget _buildImage() {
    return new Positioned.fill(
      bottom: null,
      child: new ClipPath(
        clipper: new DialogonalClipper(),
        child: new Image.asset(
          'assets/images/App.png',
          fit: BoxFit.cover,
          height: _imageHeight,
          colorBlendMode: BlendMode.darken,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildTopHeader() {
    return new Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 32.0),
      child: new Row(
        children: <Widget>[
          new IconButton(
              icon: new Icon(Icons.menu),
              color: Colors.white,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              }),
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: new Text(
                "Timeline",
                style: new TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
          new Icon(Icons.linear_scale, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildProfileRow() {
    return new Padding(
      padding: new EdgeInsets.only(left: 16.0, top: _imageHeight / 2.5),
      child: new Row(
        children: <Widget>[
          new CircleAvatar(
            minRadius: 28.0,
            maxRadius: 28.0,
            backgroundImage: new AssetImage('assets/images/susan.png'),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(
                  Session().employee.displayName,
                  style: new TextStyle(
                      fontSize: 26.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
                new Text(
                  'Redistributer',
                  style: new TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPart() {
<<<<<<< .mine
    var list = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildMyTasksHeader(),
        _buildTasksList(),
      ],
    );

    var options = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new FlatButton(onPressed: null, child: new Text('Show market')),
        new FlatButton(onPressed: null, child: new Text('Sell')),
      ],
    );

































































=======
    var list = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildMyTasksHeader(),
        _buildTasksList(),
      ],
    );

    var options = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Padding(
          padding: EdgeInsets.only(top: 10.0),
        ),
        //new FlatButton(onPressed: null, child: new Text('Show market')),
        //new FlatButton(onPressed: null, child: new Text('Sell')),
        Container(
          //width: 120.0,
          height: 50.0,
          child: RaisedButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0)),
              elevation: 2.0,
              color: Colors.green,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Icon(
                    FontAwesomeIcons.shoppingCart,
                    color:  Colors.white,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                  ),
                  Text('Show market', style: buttonTextStyle)
                ],
              ),
              onPressed: () {
                setState(() {
                  titleA = 'Marketplace';
                  showOptions = false;
                });
              })
        ),
        new Padding(
          padding: EdgeInsets.only(top: 10.0),
        ),
        Container(
          //width: 120.0,
          height: 50.0,
          child: RaisedButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0)),
              elevation: 2.0,
              color: Colors.green,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Icon(
                    FontAwesomeIcons.moneyBillWave,
                    color:  Colors.white,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                  ),
                  Text('Sell', style: buttonTextStyle)
                ],
              ),
              onPressed: () {
                setState(() {
                  titleA = 'Selling items';
                  showOptions = false;
                });
              })
        )
      ],
    );

>>>>>>> .theirs
    return new Padding(
<<<<<<< .mine
      padding: new EdgeInsets.only(top: _imageHeight),
      child: showOptions ? options : list
=======
        padding: new EdgeInsets.only(top: _imageHeight),
        child: showOptions ? options : list
>>>>>>> .theirs
    );
  }

  Widget _buildTasksList() {
    return new Expanded(
      child: new AnimatedList(
        initialItemCount: tasks.length,
        key: _listKey,
        itemBuilder: (context, index, animation) {
          return new TaskRow(
            task: listModel[index],
            animation: animation,
          );
        },
      ),
    );
  }

  Widget _buildMyTasksHeader() {
    return new Padding(
      padding: new EdgeInsets.only(left: 64.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            titleA,
            style: new TextStyle(fontSize: 34.0),
          ),
          new Text(
            'OCTOBER 12, 2018',
            style: new TextStyle(color: Colors.grey, fontSize: 12.0),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    return new Positioned(
      top: 0.0,
      bottom: 0.0,
      left: 32.0,
      child: new Container(
        width: 1.0,
        color: Colors.grey[300],
      ),
    );
  }
}