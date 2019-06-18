import 'package:flutter/material.dart';
import 'package:flutter_ui_template/utils/logger.dart';
import 'package:flutter_ui_template/generated/i18n.dart';

import 'air_asia_bar.dart';
import 'rounded_button.dart';
import 'content_card.dart';

/// use to show log
final _logger = Log("flight_search_screen");

class FlightSearchScreen extends StatefulWidget {
  @override
  _FlightSearchScreenState createState() => _FlightSearchScreenState();
}

class _FlightSearchScreenState extends State<FlightSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AirAsiaBar(height: 210.0),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 40.0),
              child: Column(
                children: <Widget>[
                  _buildButtonRow(),
                  Expanded(child: ContentCard()),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButtonRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          RoundedButton(text: "ONE WAY"),
          RoundedButton(text: "ROUND"),
          RoundedButton(text: "MULTICITY", selected: true),
        ],
      ),
    );
  }
}
