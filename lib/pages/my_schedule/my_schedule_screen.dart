import 'package:flutter/material.dart';
import 'package:flutter_ui_template/utils/logger.dart';
import 'package:flutter_ui_template/generated/i18n.dart';

import 'card_item_model.dart';


final Log _logger = new Log("my_schedule_screen");

class MyScheduleScreen extends StatefulWidget {
  @override
  _MyScheduleScreenState createState() => _MyScheduleScreenState();
}

class _MyScheduleScreenState extends State<MyScheduleScreen> with TickerProviderStateMixin {

  var _appColors = [Color.fromRGBO(231, 129, 109, 1.0),
    Color.fromRGBO(99, 138, 223, 1.0), Color.fromRGBO(111, 194, 173, 1.0)];

  var _cardIndex = 0;
  var _currentColor = Color.fromRGBO(231, 129, 109, 1.0);

  var _cardList = [
    CardItemModel("Personal", Icons.account_circle, 9, 0.83),
    CardItemModel("Work", Icons.work, 12, 0.24),
    CardItemModel("Home", Icons.home, 7, 0.32),
  ];

  ScrollController _scrollController;
  AnimationController _animationController;
  ColorTween _colorTween;
  CurvedAnimation _curvedAnimation;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _currentColor,
      drawer: Drawer(),
      appBar: AppBar(
        title: Text(
          S.of(context).my_schedule_title,
          style: TextStyle(fontSize: 16.0),
        ),
        backgroundColor: _currentColor,
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.search),
          )
        ],
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 64.0, vertical: 10.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Icon(Icons.account_circle, size: 45.0, color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 4.0),
                      child: Text(
                        "Hello, Jane",
                        style: TextStyle(fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Text(
                      "Looks like feel good.",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "You have 3 tasks to do today.",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 64.0, vertical: 0.0),
                  child: Text(
                    "TODAY: JUL 21, 2019",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  height: 350.0,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, position) {
                      return GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Container(
                              width: 250.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Icon(_cardList[position].icon, color: _appColors[position],),
                                        Icon(Icons.more_vert, color: Colors.grey,),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                          child: Text("${_cardList[position].tasksRemaining} Tasks", style: TextStyle(color: Colors.grey),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                          child: Text("${_cardList[position].cardTitle}", style: TextStyle(fontSize: 28.0),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: LinearProgressIndicator(value: _cardList[position].taskCompletion,),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                          ),
                        ),
                        onHorizontalDragEnd: (details) {
                          _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
                          _curvedAnimation = CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn);

                          _animationController.addListener(() {
                            setState(() {
                              _currentColor = _colorTween.evaluate(_curvedAnimation);
                            });
                          });
                          
                          if (details.velocity.pixelsPerSecond.dx > 0) {
                            if (_cardIndex > 0) {
                              _cardIndex--;
                            }
                          } else {
                            if (_cardIndex < 2) {
                              _cardIndex++;
                            }
                          }
                          _colorTween = ColorTween(begin: _currentColor, end: _appColors[_cardIndex]);
                          _colorTween.animate(_curvedAnimation);
                          _animationController.forward();

                          setState(() {
                            _scrollController.animateTo((_cardIndex)*256.0, duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        )
      ),
    );
  }
}