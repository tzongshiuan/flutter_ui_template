import 'package:flutter/material.dart';
import 'package:flutter_ui_template/utils/logger.dart';
import 'package:flutter_ui_template/generated/i18n.dart';

import 'dial_call_page.dart';
import 'miss_call_page.dart';
import 'receive_call_page.dart';

class TabBarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: "Calls", icon: Icon(Icons.call_made)),
              Tab(text: "Missed", icon: Icon(Icons.call_missed)),
              Tab(text: "Received", icon: Icon(Icons.call_received)),
            ],
          ),
          title: Text(S.of(context).tab_bar_title),
        ),
        body: TabBarView(
          children: <Widget>[
            DialledCallsPage(),
            MissedCallsPage(),
            ReceivedCallsPage(),
          ],
        ),
      ),
    );
  }
}