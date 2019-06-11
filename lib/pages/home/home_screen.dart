import 'package:flutter/material.dart';
import 'package:flutter_ui_template/utils/logger.dart';
import 'package:flutter_ui_template/utils/my_navigator.dart';
import 'package:flutter_ui_template/generated/i18n.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final Log _logger = new Log("home_screen");

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    _logger.fine(message: 'build()');

    return Scaffold(
      appBar: AppBar(
        leading: new Container(width: 0.0),
        title: new Text(widget.title),
        actions: <Widget>[
          new Container()
        ],
      ),
      body: Center(
        child: _myListView(context),
      ),
    );
  }

  Widget _myListView(BuildContext context) {
    final titles = [
      S.of(context).bottom_nav_title,
      S.of(context).drawer_nav_title
    ];

    final icons = [Icons.directions_boat,
      Icons.directions_bus, Icons.directions_car, Icons.directions_railway,
      Icons.directions_run, Icons.directions_subway, Icons.directions_transit,
      Icons.directions_walk];

    return ListView.builder(
      itemCount: titles.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              child: new Text(titles[index][0] + titles[index][1] + titles[index][2]),
              backgroundColor: Colors.orangeAccent,
              foregroundColor: Colors.white,
            ), //Icon(icons[index]),
            title: Text(titles[index]),
            onTap: () {
              _logger.fine(message: "onTap index: $index");
              switch (index) {
                case 0:
                  // goto first template
                  MyNavigator.goToBottomNavigation(context);
                  break;
                case 1:
                  MyNavigator.goToDrawerNavigation(context);
                  break;
                default:
              }
            },
          ),
        );
      },
    );
  }
}