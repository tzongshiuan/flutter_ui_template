import 'package:flutter/material.dart';
import 'package:flutter_ui_template/utils/logger.dart';
import 'package:flutter_ui_template/generated/i18n.dart';

class AirAsiaBar extends StatelessWidget {
  final double height;
  const AirAsiaBar({Key key, this.height}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.red, const Color(0xFFE64C85)]
            ),
          ),
          height: height,
        ),
        AppBar(
          backgroundColor: Colors.transparent,
          leading: Container(),
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            S.of(context).flight_search_title,
            style: TextStyle(fontFamily: null, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}