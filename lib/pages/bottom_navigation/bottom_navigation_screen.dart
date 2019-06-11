import 'package:flutter/material.dart';
import 'package:flutter_ui_template/utils/logger.dart';
import 'package:flutter_ui_template/generated/i18n.dart';

import 'person_page.dart';
import 'email_page.dart';
import 'alarm_page.dart';
import 'airplay_page.dart';

class BottomNavigationScreen extends StatefulWidget {
  BottomNavigationScreen({Key key, this.title}): super(key: key);
  final String title;

  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  final _bottomNavigationColor = Colors.blue;
  int _currentIndex = 0;
  List<Widget> list = List();

  var _controller = PageController(
    initialPage: 0
  );

  final Log _logger = new Log("bottom_navigation_screen");

  @override
  void initState() {
    super.initState();

    // cascade notation
    list..add(PersonPage())
      ..add(EmailPage())
      ..add(AlarmPage())
      ..add(AirplayPage());
  }

  BottomNavigationBarItem _navigationItemBuilder(IconData iconData, String title) {
    return BottomNavigationBarItem(
      icon: Icon(
        iconData,
        color: _bottomNavigationColor,
      ),
      title: Text(
        title,
        style: TextStyle(color: _bottomNavigationColor),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
      body: PageView(
        controller: _controller,
        children: list,
        physics: AlwaysScrollableScrollPhysics(),
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          _navigationItemBuilder(Icons.person, S.of(context).bottom_person),
          _navigationItemBuilder(Icons.email, S.of(context).bottom_email),
          _navigationItemBuilder(Icons.alarm, S.of(context).bottom_alarm),
          _navigationItemBuilder(Icons.airplay, S.of(context).bottom_airplay),
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          _logger.fine(message: "onTap, index: $index");
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.shifting,
      ),
    );
  }
}