import 'package:flutter/material.dart';
import 'package:flutter_ui_template/generated/i18n.dart';

class AirplayPage extends StatefulWidget {
  @override
  _AirplayPageState createState() => _AirplayPageState();
}

class _AirplayPageState extends State<AirplayPage> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).bottom_airplay),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times: '),
            Text(
                '$_counter',
                style: Theme.of(context).textTheme.display1
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}